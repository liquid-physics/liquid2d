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

class BallFall extends StatefulWidget {
  static const route = '/';

  const BallFall({super.key});

  @override
  State<BallFall> createState() => _BallFallState();
}

class _BallFallState extends State<BallFall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context), body: const BallLayoutSize());
  }
}

class BallLayoutSize extends StatelessWidget {
  const BallLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => BallView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class BallView extends StatefulWidget {
  const BallView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<BallView> createState() => _BallViewState();
}

class _BallViewState extends State<BallView> {
  late final Game _game;
  void initGame(lq.Space space) {}

  @override
  void dispose() {
    _game.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _game = Game(widget.width, widget.height);
    _game.init(initGame);
    _game.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(children: [
          BallDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class BallDraw extends StatefulWidget {
  const BallDraw({
    super.key,
    required this.game,
  });
  final Game game;

  @override
  State<BallDraw> createState() => _BallDrawState();
}

class _BallDrawState extends State<BallDraw> {
  var ball = <_CircleShape>[];
  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  @override
  void initState() {
    super.initState();
    late lq.Body staticBody;
    widget.game.isDebugDrawEnable = true;
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -100))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);
    staticBody = widget.game.space.getStaticBody();
    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(widget.game.spaceMatrix.size.x / 2, widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);

    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
    ball = [
      for (int i = 0; i < 5; i++)
        for (int j = 0; j <= i; j++) ...[
          _CircleShape(
            space: widget.game.space,
            pos: mt.Vector2(j * 32 - i * 16, 300 - i * 32),
            radius: next(5, 15),
            color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          )
        ]
    ];
    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  void addBall(details) {
    ball.add(_CircleShape(
        space: widget.game.space, radius: next(5, 15), pos: widget.game.spaceMatrix.mouseToView(details.localPosition), color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned.fill(
            child: InputW(
              game: widget.game,
              onDoubleTapDown: addBall,
              onSecondaryTapDown: addBall,
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: ball,
                ),
              ),
            ),
          )
        ],
      ),
    );
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
