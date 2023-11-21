import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:vector_math/vector_math_64.dart' as mt;

class TheoJansen extends StatefulWidget {
  const TheoJansen({super.key});
  static const route = '/theojansen';
  @override
  State<TheoJansen> createState() => _TheoJansenState();
}

class _TheoJansenState extends State<TheoJansen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const TheoJansenLayoutSize(),
    );
  }
}

class TheoJansenLayoutSize extends StatelessWidget {
  const TheoJansenLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TheoJansenView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class TheoJansenView extends StatefulWidget {
  const TheoJansenView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<TheoJansenView> createState() => _TheoJansenViewState();
}

class _TheoJansenViewState extends State<TheoJansenView> {
  late final Game _game;
  @override
  void initState() {
    super.initState();
    _game = Game(widget.width, widget.height);
    _game.start();
  }

  @override
  void dispose() {
    _game.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(children: [
          TheoJansenDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class TheoJansenDraw extends StatefulWidget {
  const TheoJansenDraw({super.key, required this.game});

  final Game game;

  @override
  State<TheoJansenDraw> createState() => _TheoJansenDrawState();
}

class _TheoJansenDrawState extends State<TheoJansenDraw> {
  var segment = <_SegmentShape>[];
  var leg = <_LegShape>[];
  late _ChassisShape chassis;
  late _CrankShape crank;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 20)
      ..setGravity(gravity: mt.Vector2(0, -500));
    var staticBody = widget.game.space.getStaticBody();
    segment = [
      _SegmentShape(color: Colors.white, radius: 0, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 0, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 0, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody)
    ];

    chassis = _ChassisShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), space: widget.game.space);
    crank = _CrankShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 13, space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: chassis.body, b: crank.body, anchorA: mt.Vector2.zero(), anchorB: mt.Vector2.zero()));
    var side = 30.0;
    var offset = 30.0;
    leg = [
      for (var i = 0; i < 2; i++) ...[
        _LegShape(
            color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            space: widget.game.space,
            side: side,
            offset: offset,
            chassis: chassis.body,
            crank: crank.body,
            anchor: mt.Vector2(cos(2 * i + 0 / 2 * pi), sin(2 * i + 0 / 2 * pi)) * 13),
        _LegShape(
            color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            space: widget.game.space,
            side: side,
            offset: -offset,
            chassis: chassis.body,
            crank: crank.body,
            anchor: mt.Vector2(cos(2 * i + 1 / 2 * pi), sin(2 * i + 1 / 2 * pi)) * 13)
      ]
    ];

    var motor = widget.game.space.addConstraint(constraint: lq.SimpleMotor(a: chassis.body, b: crank.body, rate: 6));

    var x = 0;
    var y = 0;
    widget.game.keyboardUpdate = ((event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.bracketLeft) x = -1;
        if (event.logicalKey == LogicalKeyboardKey.bracketRight) x = 1;
      }
      if (event is KeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.bracketLeft || event.logicalKey == LogicalKeyboardKey.bracketRight) x = 0;
      }
    });

    widget.game.physicUpdateBefore = ((event) {
      double coef = (2.0 + y) / 3.0;
      double rate = x * 10.0 * coef;
      motor.setRate(rate);
      motor.setMaxForce(rate > 0 || rate < 0 ? 1000000.0 : 0);
    });

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InputW(
            game: widget.game,
            child: CustomPaint(
              painter: RenderPainter(
                game: widget.game,
                shapes: [...segment, chassis, crank, ...leg],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SegmentShape extends PaintShape {
  _SegmentShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.posA,
    required this.posB,
    required this.staticBody,
  }) {
    space.addShape(shape: lq.SegmentShape(body: staticBody, a: posA, b: posB, radius: radius))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final mt.Vector2 posA;
  final mt.Vector2 posB;
  final lq.Body staticBody;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(posA.x, -posA.y),
        Offset(posB.x, -posB.y),
        Paint()
          ..color = color
          ..strokeWidth = radius * 2
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}

class _ChassisShape extends PaintShape {
  _ChassisShape({
    required this.color,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: 2, moment: lq.Moment.forSegment(2, a, b, 0)));
    space.addShape(shape: lq.SegmentShape(body: body, a: a, b: b, radius: 3)).setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
  }
  final Color color;
  final lq.Space space;
  late lq.Body body;
  mt.Vector2 a = mt.Vector2(-30, 0);
  mt.Vector2 b = mt.Vector2(30, 0);
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawLine(
        Offset(body.getPosition().x + a.x, -body.getPosition().y + a.y),
        Offset(body.getPosition().x + b.x, -body.getPosition().y + b.y),
        Paint()
          ..color = color
          ..strokeWidth = 3 * 2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _CrankShape extends PaintShape {
  _CrankShape({
    required this.color,
    required this.radius,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: 1.0, moment: lq.Moment.forCircle(1.0, radius, 0, mt.Vector2.zero())));
    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero())).setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
  }
  final double radius;
  final Color color;
  final lq.Space space;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawCircle(Offset(body.getPosition().x, -body.getPosition().y), radius, Paint()..color = color);
    canvas.drawLine(
        Offset(body.getPosition().x, -body.getPosition().y),
        Offset(body.getPosition().x + radius - 1, -body.getPosition().y),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _LegShape extends PaintShape {
  _LegShape({
    required this.color,
    required this.space,
    required this.side,
    required this.offset,
    required this.chassis,
    required this.crank,
    required this.anchor,
  }) {
    // upper leg
    var a = mt.Vector2.zero();
    var b = mt.Vector2(0, side);
    var legMass = 1.0;
    var radius = 3.0;
    upperLeg = space.addBody(body: lq.Body(mass: legMass, moment: lq.Moment.forSegment(legMass, a, b, 0)))..setPosition(pos: mt.Vector2(offset, 0));
    space.addShape(shape: lq.SegmentShape(body: upperLeg, a: a, b: b, radius: radius)).setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
    space.addConstraint(constraint: lq.PivotJoint(a: chassis, b: upperLeg, anchorA: mt.Vector2(offset, 0), anchorB: mt.Vector2.zero()));

    // lower leg
    a = mt.Vector2.zero();
    b = mt.Vector2(0, -1 * side);
    lowerLeg = space.addBody(body: lq.Body(mass: legMass, moment: lq.Moment.forSegment(legMass, a, b, 0)))..setPosition(pos: mt.Vector2(offset, -side));
    space.addShape(shape: lq.SegmentShape(body: lowerLeg, a: a, b: b, radius: radius)).setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));

    // shoes
    space.addShape(shape: lq.CircleShape(body: lowerLeg, radius: radius * 2, offset: b))
      ..setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories))
      ..setElasticity(0)
      ..setFriction(1);

    space.addConstraint(constraint: lq.PinJoint(a: chassis, b: lowerLeg, anchorA: mt.Vector2(offset, 0), anchorB: mt.Vector2.zero()));
    space.addConstraint(constraint: lq.GearJoint(a: upperLeg, b: lowerLeg, phase: 0, ratio: 1));

    var diag = sqrt(side * side + offset * offset);
    (space.addConstraint(constraint: lq.PinJoint(a: crank, b: upperLeg, anchorA: anchor, anchorB: mt.Vector2(0, side)))).setDist(diag);
    (space.addConstraint(constraint: lq.PinJoint(a: crank, b: lowerLeg, anchorA: anchor, anchorB: mt.Vector2.zero()))).setDist(diag);
  }
  final Color color;
  final lq.Space space;
  final double side;
  final double offset;
  final lq.Body chassis;
  final lq.Body crank;
  final mt.Vector2 anchor;
  late lq.Body upperLeg;
  late lq.Body lowerLeg;
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: upperLeg.getPosition().x, cy: -upperLeg.getPosition().y, angle: -upperLeg.getAngle());
    canvas.drawLine(
        Offset(upperLeg.getPosition().x, -upperLeg.getPosition().y),
        Offset(upperLeg.getPosition().x, -upperLeg.getPosition().y + -side),
        Paint()
          ..color = color
          ..strokeWidth = 3 * 2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
    canvas.save();
    rotate(canvas: canvas, cx: lowerLeg.getPosition().x, cy: -lowerLeg.getPosition().y, angle: -lowerLeg.getAngle());
    canvas.drawLine(
        Offset(lowerLeg.getPosition().x, -lowerLeg.getPosition().y),
        Offset(lowerLeg.getPosition().x, -lowerLeg.getPosition().y + side),
        Paint()
          ..color = color
          ..strokeWidth = 3 * 2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
    canvas.save();
    rotate(canvas: canvas, cx: lowerLeg.getPosition().x, cy: -lowerLeg.getPosition().y, angle: -lowerLeg.getAngle());
    canvas.drawCircle(Offset(lowerLeg.getPosition().x, -lowerLeg.getPosition().y + side), 3 * 2, Paint()..color = color);
    canvas.drawLine(
        Offset(lowerLeg.getPosition().x, -lowerLeg.getPosition().y + side),
        Offset(lowerLeg.getPosition().x + 3 * 2 - 1, -lowerLeg.getPosition().y + side),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
