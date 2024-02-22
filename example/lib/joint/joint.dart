import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Joint extends StatefulWidget {
  const Joint({super.key});
  static const route = '/joint';

  @override
  State<Joint> createState() => _JointState();
}

class _JointState extends State<Joint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const JointLayoutSize(),
    );
  }
}

class JointLayoutSize extends StatelessWidget {
  const JointLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => JointView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class JointView extends StatefulWidget {
  const JointView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<JointView> createState() => _JointViewState();
}

class _JointViewState extends State<JointView> {
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
          JointDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class JointDraw extends StatefulWidget {
  const JointDraw({super.key, required this.game});
  final Game game;

  @override
  State<JointDraw> createState() => _JointDrawState();
}

class _JointDrawState extends State<JointDraw> {
  var segmentLine = <_SegmentShape>[];
  var ex4 = <_CircleShape>[];
  var ex5 = <_BarShape>[];
  var ex6 = <_BarShape>[];
  var ex7 = <_BarShape>[];
  var ex3 = <_BarShape>[];
  var ex2 = <_BarShape>[];
  var ex8 = <_CircleShape>[];
  var ex9 = <_CircleShape>[];
  var ex10 = <_CircleShape>[];
  var ex11 = <_CircleShape>[];
  var ex1 = <PaintShape>[];
  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 10)
      ..setGravity(gravity: mt.Vector2(0, -100))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5);
    var staticBody = widget.game.space.getStaticBody();
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 120), posB: mt.Vector2(320, 120), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 0), posB: mt.Vector2(320, 0), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -120), posB: mt.Vector2(320, -120), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-160, -240), posB: mt.Vector2(-160, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(0, -240), posB: mt.Vector2(0, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(160, -240), posB: mt.Vector2(160, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];
    var posA = mt.Vector2(50, 60);
    var posB = mt.Vector2(110, 60);
    var boxoffset = mt.Vector2(-320, -240);
    var bd1 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    var bd2 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    widget.game.space.addConstraint(constraint: lq.PinJoint(a: bd1.body, b: bd2.body, anchorA: mt.Vector2(15, 0), anchorB: mt.Vector2(-15, 0)));
    ex8 = [bd1, bd2];

    boxoffset = mt.Vector2(-160, -240);
    bd1 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    bd2 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    widget.game.space.addConstraint(constraint: lq.SlideJoint(a: bd1.body, b: bd2.body, anchorA: mt.Vector2(15, 0), anchorB: mt.Vector2(-15, 0), min: 20, max: 40));
    ex9 = [bd1, bd2];

    boxoffset = mt.Vector2(0, -240);
    bd1 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    bd2 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bd1.body, b: bd2.body, anchorA: mt.Vector2(30, 0), anchorB: mt.Vector2(-30, 0)));
    ex10 = [bd1, bd2];

    boxoffset = mt.Vector2(160, -240);
    bd1 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    bd2 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    widget.game.space.addConstraint(constraint: lq.GrooveJoint(a: bd1.body, b: bd2.body, grooveA: mt.Vector2(30, 30), grooveB: mt.Vector2(30, -30), anchorB: mt.Vector2(-30, 0)));
    ex11 = [bd1, bd2];

    boxoffset = mt.Vector2(-320, -120);
    bd1 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    bd2 = _CircleShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    widget.game.space.addConstraint(constraint: lq.DampedSpring(a: bd1.body, b: bd2.body, anchorA: mt.Vector2(30, -30), anchorB: mt.Vector2(-30, 0), restLength: 20, stiffness: 5, damping: .5));
    ex4 = [bd1, bd2];

    boxoffset = mt.Vector2(-160, -120);
    var bdb1 = _BarShape(color: Colors.lightBlue, pos: posA + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    var bdb2 = _BarShape(color: Colors.lightBlue, pos: posB + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb1.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posA + boxoffset));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb2.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posB + boxoffset));
    widget.game.space.addConstraint(constraint: lq.DampedRotarySpring(a: bdb1.body, b: bdb2.body, restAngle: 0, stiffness: 3000, damping: 60));
    ex5 = [bdb1, bdb2];

    boxoffset = mt.Vector2(0, -120);
    bdb1 = _BarShape(color: Colors.lightBlue, pos: posA + boxoffset, radius: 5, posA: mt.Vector2(0, -15), posB: mt.Vector2(0, 15), space: widget.game.space);
    bdb2 = _BarShape(color: Colors.lightBlue, pos: posB + boxoffset, radius: 5, posA: mt.Vector2(0, -15), posB: mt.Vector2(0, 15), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb1.body, b: staticBody, anchorA: mt.Vector2(0, 15), anchorB: posA + boxoffset));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb2.body, b: staticBody, anchorA: mt.Vector2(0, 15), anchorB: posB + boxoffset));
    widget.game.space.addConstraint(constraint: lq.RotaryLimitJoint(a: bdb1.body, b: bdb2.body, min: -pi / 2, max: pi / 2));
    ex6 = [bdb1, bdb2];

    boxoffset = mt.Vector2(160, -120);
    bdb1 = _BarShape(color: Colors.lightBlue, pos: posA + boxoffset, radius: 5, posA: mt.Vector2(0, -15), posB: mt.Vector2(0, 15), space: widget.game.space);
    bdb2 = _BarShape(color: Colors.lightBlue, pos: posB + boxoffset, radius: 5, posA: mt.Vector2(0, -15), posB: mt.Vector2(0, 15), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb1.body, b: staticBody, anchorA: mt.Vector2(0, 15), anchorB: posA + boxoffset));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb2.body, b: staticBody, anchorA: mt.Vector2(0, 15), anchorB: posB + boxoffset));
    widget.game.space.addConstraint(constraint: lq.RatchetJoint(a: bdb1.body, b: bdb2.body, phase: 0, ratchet: pi / 2));
    ex7 = [bdb1, bdb2];

    boxoffset = mt.Vector2(-320, 0);
    bdb1 = _BarShape(color: Colors.lightBlue, pos: posA + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    bdb2 = _BarShape(color: Colors.lightBlue, pos: posB + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb1.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posA + boxoffset));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb2.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posB + boxoffset));
    widget.game.space.addConstraint(constraint: lq.GearJoint(a: bdb1.body, b: bdb2.body, phase: 0, ratio: 2));
    ex3 = [bdb1, bdb2];

    boxoffset = mt.Vector2(-160, 0);
    bdb1 = _BarShape(color: Colors.lightBlue, pos: posA + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    bdb2 = _BarShape(color: Colors.lightBlue, pos: posB + boxoffset, radius: 5, posA: mt.Vector2(0, -30), posB: mt.Vector2(0, 30), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb1.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posA + boxoffset));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: bdb2.body, b: staticBody, anchorA: mt.Vector2(0, 0), anchorB: posB + boxoffset));
    widget.game.space.addConstraint(constraint: lq.SimpleMotor(a: bdb1.body, b: bdb2.body, rate: pi));
    ex2 = [bdb1, bdb2];

    boxoffset = mt.Vector2(0, 0);
    var w1 = _WheelShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posA + boxoffset);
    var w2 = _WheelShape(color: Colors.lightBlue, radius: 15, space: widget.game.space, pos: posB + boxoffset);
    var chs = _ChassiShape(color: Colors.lightBlue, pos: mt.Vector2(80, 100) + boxoffset, radius: 15, posA: mt.Vector2(-40, 0), posB: mt.Vector2(40, 0), space: widget.game.space);
    widget.game.space.addConstraint(constraint: lq.GrooveJoint(a: chs.body, b: w1.body, grooveA: mt.Vector2(-30, -10), grooveB: mt.Vector2(-30, -40), anchorB: mt.Vector2.zero()));
    widget.game.space.addConstraint(constraint: lq.GrooveJoint(a: chs.body, b: w2.body, grooveA: mt.Vector2(30, -10), grooveB: mt.Vector2(30, -40), anchorB: mt.Vector2.zero()));
    widget.game.space.addConstraint(constraint: lq.DampedSpring(a: chs.body, b: w1.body, anchorA: mt.Vector2(-30, 0), anchorB: mt.Vector2.zero(), restLength: 50, stiffness: 20, damping: 10));
    widget.game.space.addConstraint(constraint: lq.DampedSpring(a: chs.body, b: w2.body, anchorA: mt.Vector2(30, 0), anchorB: mt.Vector2.zero(), restLength: 50, stiffness: 20, damping: 10));

    ex1 = [w1, w2, chs];

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
                  ...segmentLine,
                  ...ex8,
                  ...ex9,
                  ...ex10,
                  ...ex11,
                  ...ex4,
                  ...ex5,
                  ...ex6,
                  ...ex7,
                  ...ex3,
                  ...ex2,
                  ...ex1,
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

class _BarShape extends PaintShape {
  _BarShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.posA,
    required this.posB,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 2, moment: lq.Moment.forSegment(2, posA, posB, radius)))..setPosition(pos: pos);
    space.addShape(shape: lq.SegmentShape(body: body, a: posA, b: posB, radius: radius))
      ..setElasticity(0)
      ..setFriction(.7)
      ..setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final mt.Vector2 posA;
  final mt.Vector2 posB;
  final mt.Vector2 pos;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawLine(
        Offset(body.getPosition().x + posA.x, -body.getPosition().y + posA.y),
        Offset(body.getPosition().x + posB.x, -body.getPosition().y + posB.y),
        Paint()
          ..color = color
          ..strokeWidth = radius * 2
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

class _ChassiShape extends PaintShape {
  _ChassiShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.posA,
    required this.posB,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 2, moment: lq.Moment.forSegment(2, posA, posB, radius)))..setPosition(pos: pos);
    space.addShape(shape: lq.SegmentShape(body: body, a: posA, b: posB, radius: radius))
      ..setElasticity(0)
      ..setFriction(.7)
      ..setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final mt.Vector2 posA;
  final mt.Vector2 posB;
  final mt.Vector2 pos;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawLine(
        Offset(body.getPosition().x + posA.x, -body.getPosition().y + posA.y),
        Offset(body.getPosition().x + posB.x, -body.getPosition().y + posB.y),
        Paint()
          ..color = color
          ..strokeWidth = radius * 2
          ..strokeJoin = StrokeJoin.miter);
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

class _WheelShape extends PaintShape {
  _WheelShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 1.0, moment: lq.Moment.forCircle(1.0, 0.0, radius, mt.Vector2.zero())))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(.5)
      ..setFriction(1)
      ..setFilter(lq.ShapeFilter(group: 1, categories: allCategories, mask: allCategories));
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
