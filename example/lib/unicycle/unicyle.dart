// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Unicycle extends StatefulWidget {
  const Unicycle({super.key});
  static const route = '/unicyle';

  @override
  State<Unicycle> createState() => _UnicycleState();
}

class _UnicycleState extends State<Unicycle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const UnicycleLayoutSize(),
    );
  }
}

class UnicycleLayoutSize extends StatelessWidget {
  const UnicycleLayoutSize({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => UnicycleView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class UnicycleView extends StatefulWidget {
  const UnicycleView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<UnicycleView> createState() => _UnicycleViewState();
}

class _UnicycleViewState extends State<UnicycleView> {
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
          UnicycleDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class UnicycleDraw extends StatefulWidget {
  const UnicycleDraw({super.key, required this.game});
  final Game game;
  @override
  State<UnicycleDraw> createState() => _UnicycleDrawState();
}

class _UnicycleDrawState extends State<UnicycleDraw> {
  var shp = <PaintShape>[];
  var mouse = mt.Vector2.zero();
  @override
  void initState() {
    super.initState();

    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -500));

    var staticBody = widget.game.space.getStaticBody();
    shp = [
      _SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(-3200, -240), posB: mt.Vector2(3200, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(0, -200), posB: mt.Vector2(240, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(-240, -240), posB: mt.Vector2(0, -200), staticBody: staticBody),
      _BoxShape(color: Colors.purple, width: 100, height: 20, space: widget.game.space, pos: mt.Vector2(200, -100))
    ];
    var wheel = _CircleShape(color: Colors.blueAccent, radius: 20, space: widget.game.space, pos: mt.Vector2(0, -160));
    shp.add(wheel);
    var wheelBody = wheel.body;
    var bd = _BodyShape(color: Colors.orangeAccent, space: widget.game.space, pos: mt.Vector2(0.0, wheelBody.getPosition().y + 30));
    shp.add(bd);

    var anchorA = bd.body.worldToLocal(wheelBody.getPosition());

    var groove_a = anchorA + mt.Vector2(0.0, 30.0);
    var groove_b = anchorA + mt.Vector2(0.0, -10.0);
    widget.game.space.addConstraint(constraint: lq.GrooveJoint(a: bd.body, b: wheelBody, grooveA: groove_a, grooveB: groove_b, anchorB: mt.Vector2.zero()));
    widget.game.space.addConstraint(constraint: lq.DampedSpring(a: bd.body, b: wheelBody, anchorA: anchorA, anchorB: mt.Vector2.zero(), restLength: 0, stiffness: 6.0e2, damping: 30));
    var balance_sin = 0.0;
    widget.game.space.addConstraint(constraint: lq.SimpleMotor(a: wheelBody, b: bd.body, rate: 0)).setPreSolveFunc((constraint, space) {
      var dt = space.getCurrentTimeStep();

      var target_x = mouse.x;

      var max_v = 500.0;
      var target_v = clampDouble(bias_coef(0.5, dt / 1.2) * (target_x - bd.body.getPosition().x) / dt, -max_v, max_v);
      var error_v = (target_v - bd.body.getVelocity().x);
      var target_sin = 3.0e-3 * bias_coef(0.1, dt) * error_v / dt;

      var max_sin = sin(0.6);
      balance_sin = clampDouble(balance_sin - 6.0e-5 * bias_coef(0.2, dt) * error_v / dt, -max_sin, max_sin);
      var target_a = asin(clampDouble(-target_sin + balance_sin, -max_sin, max_sin));
      var angular_diff = asin(bd.body.getRotation().cross(mt.Vector2(cos(target_a), sin(target_a))));
      var target_w = bias_coef(0.1, dt / 0.4) * (angular_diff) / dt;

      var max_rate = 50.0;
      var rate = clampDouble(wheelBody.getAngularVelocity() + bd.body.getAngularVelocity() - target_w, -max_rate, max_rate);
      (constraint as lq.SimpleMotor)
        ..setRate(clampDouble(rate, -max_rate, max_rate))
        ..setMaxForce(8.0e4);
    });

    //cpConstraintSetPreSolveFunc(motor, motor_preSolve);

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  double bias_coef(double errorBias, double dt) {
    return 1.0 - pow(errorBias, dt);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerHover: (event) {
              mouse = widget.game.spaceMatrix.mouseToView(Offset(event.localPosition.dx, event.localPosition.dy));
            },
            child: InputW(
              onSecondaryTapDown: (event) {},
              game: widget.game,
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: [...shp, _LineShape(color: Colors.red, a: mt.Vector2(mouse.x, -1000.0), b: mt.Vector2(mouse.x, 1000.0))],
                ),
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
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}

class _BoxShape extends PaintShape {
  _BoxShape({
    required this.color,
    required this.width,
    required this.height,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 3, moment: lq.Moment.forBox(3, width, height)))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))
      ..setElasticity(0)
      ..setFriction(.7);
  }

  final double width;
  final double height;
  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawRect(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: width, height: height), Paint()..color = color);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _CircleShape extends PaintShape {
  _CircleShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 1.0, moment: lq.Moment.forCircle(1.0, 0.0, radius, mt.Vector2.zero())))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setFriction(.7)
      ..setFilter(lq.ShapeFilter(group: 1, mask: allCategories, categories: allCategories));
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

class _BodyShape extends PaintShape {
  _BodyShape({
    required this.color,
    required this.space,
    required this.pos,
  }) {
    var cogOffset = 30.0;
    bb1 = lq.Rect.fromLBRT(-5.0, 0.0 - cogOffset, 5.0, cogOffset * 1.2 - cogOffset);
    bb2 = lq.Rect.fromLBRT(-25.0, bb1.top, 25.0, bb1.top + 10.0);
    var mass = 3.0;
    var moment = lq.Moment.forBox(mass, (bb1.right - bb1.left).abs(), (bb1.bottom - bb1.top).abs()) + lq.Moment.forBox(mass, (bb2.right - bb2.left).abs(), (bb2.bottom - bb2.top).abs());
    body = space.addBody(body: lq.Body(mass: mass, moment: moment))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape.fromRect(body: body, rect: bb1, radius: 0.0))
      ..setFriction(1)
      ..setFilter(lq.ShapeFilter(group: 1, mask: allCategories, categories: allCategories));

    space.addShape(shape: lq.BoxShape.fromRect(body: body, rect: bb2, radius: 0.0))
      ..setFriction(1)
      ..setFilter(lq.ShapeFilter(group: 1, mask: allCategories, categories: allCategories));
  }

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  late Rect bb1;
  late Rect bb2;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.translate(body.getPosition().x, -body.getPosition().y);
    canvas.drawRect(Rect.fromLTRB(bb1.left, -bb1.top, bb1.right, -bb1.bottom), Paint()..color = color);
    canvas.restore();

    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.translate(body.getPosition().x, -body.getPosition().y);
    canvas.drawRect(Rect.fromLTRB(bb2.left, -bb2.top, bb2.right, -bb2.bottom), Paint()..color = color);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _LineShape extends PaintShape {
  _LineShape({required this.color, required this.a, required this.b, this.radius = 2});

  final Color color;
  final mt.Vector2 a;
  final mt.Vector2 b;
  final double radius;
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}
