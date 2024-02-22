import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;
import 'package:liquid2d/liquid2d.dart' as lq;

class Pump extends StatefulWidget {
  const Pump({super.key});
  static const route = '/pump';

  @override
  State<Pump> createState() => _PumpState();
}

class _PumpState extends State<Pump> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PumpLayoutSize(),
    );
  }
}

class PumpLayoutSize extends StatelessWidget {
  const PumpLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PumpView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class PumpView extends StatefulWidget {
  const PumpView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<PumpView> createState() => _PumpViewState();
}

class _PumpViewState extends State<PumpView> {
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
          PumpDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class PumpDraw extends StatefulWidget {
  const PumpDraw({super.key, required this.game});
  final Game game;

  @override
  State<PumpDraw> createState() => _PumpDrawState();
}

class _PumpDrawState extends State<PumpDraw> {
  final _random = Random();
  var line = <_SegmentShape>[];
  var ball = <_CircleShape>[];
  late _PlungerShape plunger;
  late _FeederShape feeder;
  var gear = <_GearShape>[];
  @override
  void initState() {
    super.initState();
    widget.game.space.setGravity(gravity: mt.Vector2(0, -600));
    var staticBody = widget.game.space.getStaticBody();
    line = [
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-256, 16),
          posB: mt.Vector2(-256, 300),
          staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 2, space: widget.game.space, posA: mt.Vector2(-256, 16), posB: mt.Vector2(-192, 0), staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-192, 0),
          posB: mt.Vector2(-192, -64),
          staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-128, -64),
          posB: mt.Vector2(-128, 144),
          staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-192, 80),
          posB: mt.Vector2(-192, 176),
          staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-192, 176),
          posB: mt.Vector2(-128, 240),
          staticBody: staticBody),
      _SegmentShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 2,
          space: widget.game.space,
          posA: mt.Vector2(-128, 144),
          posB: mt.Vector2(192, 64),
          staticBody: staticBody),
    ];

    ball = [
      for (int i = 0; i < 5; i++)
        _CircleShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 30, space: widget.game.space, pos: mt.Vector2(-224.0 + i, 80.0 + 64 * i))
    ];

    plunger = _PlungerShape(space: widget.game.space, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var grs = _GearShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 80, space: widget.game.space, pos: mt.Vector2(-160, -160), angle: -pi / 2);
    var grb = _GearShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 160, space: widget.game.space, pos: mt.Vector2(80, -160), angle: pi / 2);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: staticBody, b: grs.body, anchorA: mt.Vector2(-160, -160), anchorB: mt.Vector2.zero()));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: staticBody, b: grb.body, anchorA: mt.Vector2(80, -160), anchorB: mt.Vector2.zero()));

    widget.game.space.addConstraint(constraint: lq.PinJoint(a: grs.body, b: plunger.body, anchorA: mt.Vector2(80, 0), anchorB: mt.Vector2.zero()));
    widget.game.space.addConstraint(constraint: lq.GearJoint(a: grs.body, b: grb.body, phase: -pi / 2, ratio: -2));
    gear = [grs, grb];
    feeder = _FeederShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), space: widget.game.space);

    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: staticBody, b: feeder.body, anchorA: mt.Vector2(-224, -300), anchorB: mt.Vector2(0, -332 / 2)));
    var anch = feeder.body.worldToLocal(mt.Vector2(-224, -160));
    widget.game.space.addConstraint(constraint: lq.PinJoint(a: feeder.body, b: grs.body, anchorA: anch, anchorB: mt.Vector2(0, 80)));
    var motor = widget.game.space.addConstraint(constraint: lq.SimpleMotor(a: staticBody, b: grb.body, rate: 3));
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
      double rate = x * 30.0 * coef;
      motor.setRate(rate);
      motor.setMaxForce(rate > 0 || rate < 0 ? 1000000.0 : 0);
      for (int i = 0; i < 5; i++) {
        mt.Vector2 po = ball[i].body.getPosition();

        if (po.x > 320.0) {
          ball[i].body.setVelocity(vel: mt.Vector2.zero());
          ball[i].body.setPosition(pos: mt.Vector2(-224.0, 200.0));
        }
      }
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
                shapes: [
                  ...line,
                  ...ball,
                  ...gear,
                  feeder,
                  plunger,
                ],
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
      ..setElasticity(0)
      ..setFriction(.5)
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

class _CircleShape extends PaintShape {
  _CircleShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 10.0, moment: lq.Moment.forCircle(10.0, 0.0, radius, mt.Vector2.zero())))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(.5)
      ..setFriction(1);
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;

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

class _PlungerShape extends PaintShape {
  _PlungerShape({
    required this.space,
    required this.color,
  }) {
    body = space.addBody(body: lq.Body(mass: 1, moment: double.infinity))..setPosition(pos: mt.Vector2(-160, -80));

    space.addShape(shape: lq.PolyShape(body: body, vert: _plunger, transform: Matrix4.identity(), radius: 0))
      ..setElasticity(1)
      ..setFriction(.5)
      ..setFilter(lq.ShapeFilter(group: 0, categories: 1, mask: 1));
  }

  final lq.Space space;
  late lq.Body body;
  final Color color;

  static final _plunger = <mt.Vector2>[
    mt.Vector2(-30, -80),
    mt.Vector2(-30, 80),
    mt.Vector2(30, 64),
    mt.Vector2(30, -80),
  ];

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in _plunger) Offset(ele.x + body.getPosition().x, -ele.y + -body.getPosition().y)]),
        BlendMode.dst,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _GearShape extends PaintShape {
  _GearShape({required this.color, required this.radius, required this.space, required this.pos, required this.angle}) {
    body = space.addBody(body: lq.Body(mass: 10.0, moment: lq.Moment.forCircle(10.0, radius, 0, mt.Vector2.zero())))
      ..setPosition(pos: pos)
      ..setAngle(angle);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero())).setFilter(shapeFilterNone);
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  final double angle;
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

class _FeederShape extends PaintShape {
  _FeederShape({
    required this.color,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: 1, moment: lq.Moment.forSegment(1, mt.Vector2(-224, bottom), mt.Vector2(-224, top), 0)))..setPosition(pos: mt.Vector2(-224, (bottom + top) / 2));
    space.addShape(shape: lq.SegmentShape(body: body, a: mt.Vector2(0, len / 2), b: mt.Vector2(0, -len / 2), radius: 20)).setFilter(grabFilter);
  }
  final Color color;
  final lq.Space space;
  late lq.Body body;
  static double bottom = -300;
  static double top = 32;
  static double len = top - bottom;
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawLine(
        Offset(body.getPosition().x, len / 2 - body.getPosition().y),
        Offset(body.getPosition().x, -len / 2 - body.getPosition().y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 40);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
