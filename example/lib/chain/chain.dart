import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Chain extends StatefulWidget {
  const Chain({super.key});
  static const route = '/chain';

  @override
  State<Chain> createState() => _ChainState();
}

class _ChainState extends State<Chain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const ChainLayoutSize(),
    );
  }
}

class ChainLayoutSize extends StatelessWidget {
  const ChainLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ChainView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class ChainView extends StatefulWidget {
  const ChainView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<ChainView> createState() => _ChainViewState();
}

class _ChainViewState extends State<ChainView> {
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
          ChainDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class ChainDraw extends StatefulWidget {
  const ChainDraw({super.key, required this.game});
  final Game game;
  @override
  State<ChainDraw> createState() => _ChainDrawState();
}

class _ChainDrawState extends State<ChainDraw> {
  final _random = Random();
  var segmentLine = <_SegmentShape>[];
  var chain = <PaintShape>[];
  late _CircleShape ball;

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -100))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5);
    var staticBody = widget.game.space.getStaticBody();
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];
    var width = 20;
    var height = 30;

    var spacing = width * 0.3;
    for (var i = 0; i < 8; i++) {
      lq.Body? prev;
      for (var j = 0; j < 10; j++) {
        var pos = mt.Vector2(40 * (i - (8 - 1) / 2.0), 240 - (j + 0.5) * height - (j + 1) * spacing);
        var bd = _BoxShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), space: widget.game.space, pos: pos);
        chain.add(bd);
        var breakingForce = 80000.0;
        if (prev == null) {
          widget.game.space.addConstraint(constraint: lq.SlideJoint(a: bd.body, b: staticBody, anchorA: mt.Vector2(0, height / 2), anchorB: mt.Vector2(pos.x, 240), min: 0, max: spacing))
            ..setMaxForce(breakingForce)
            ..setCollideBody(false)
            ..setPostSolveFunc(breakableJointPostSolve);
        } else {
          widget.game.space.addConstraint(constraint: lq.SlideJoint(a: bd.body, b: prev, anchorA: mt.Vector2(0, height / 2), anchorB: mt.Vector2(0, -height / 2), min: 0, max: spacing))
            ..setMaxForce(breakingForce)
            ..setCollideBody(false)
            ..setPostSolveFunc(breakableJointPostSolve);
        }

        prev = bd.body;
      }
    }

    ball = _CircleShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 15, space: widget.game.space, pos: mt.Vector2(0, -240 + 15 + 5));

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  void breakableJointPostSolve(lq.Constraint constraint, lq.Space space) {
    double dt = space.getCurrentTimeStep();

    // Convert the impulse to a force by dividing it by the timestep.
    double force = constraint.getImpulse() / dt;
    double maxForce = constraint.getMaxForce();
    //print('$force, $maxForce');

    // If the force is almost as big as the joint's max force, break it.
    if (force > 0.9 * maxForce) {
      space.addPostStepCallback<lq.Constraint>(constraint, breakablejointPostStepRemove);
    }
  }

  void breakablejointPostStepRemove(lq.Space space, lq.Constraint constraint) {
    space.removeConstraint(constraint: constraint);
    constraint.destroy();
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
                shapes: [...segmentLine, ...chain, ball],
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

class _BoxShape extends PaintShape {
  _BoxShape({
    required this.color,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: lq.Moment.forBox(mass, width, height)))..setPosition(pos: pos);
    space.addShape(shape: lq.SegmentShape(body: body, a: mt.Vector2(0, (height - width) / 2.0), b: mt.Vector2(0, (width - height) / 2.0), radius: width / 2.0)).setFriction(.8);
  }

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  final double width = 20;
  final double height = 30;
  late lq.Body body;
  static const double mass = 1;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: width, height: height), const Radius.circular(10)), Paint()..color = color);
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
    body = space.addBody(body: lq.Body(mass: 10.0, moment: lq.Moment.forCircle(10.0, 0.0, radius, mt.Vector2.zero())))
      ..setPosition(pos: pos)
      ..setVelocity(vel: mt.Vector2(0, 300));

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(0)
      ..setFriction(.9);
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
