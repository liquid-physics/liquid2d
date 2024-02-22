import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:liquid2d_example/logo_smash/image_data.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class LogoSmash extends StatefulWidget {
  static const route = '/logosmash';

  const LogoSmash({super.key});

  @override
  State<LogoSmash> createState() => _LogoSmashState();
}

class _LogoSmashState extends State<LogoSmash> {
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
      builder: (context, constraints) => LogoSmashView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class LogoSmashView extends StatefulWidget {
  const LogoSmashView({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<LogoSmashView> createState() => _LogoSmashViewState();
}

class _LogoSmashViewState extends State<LogoSmashView> {
  int imageWidth = 188;
  int imageHeight = 35;
  int imageRowLength = 24;
  late final Game _game;
  void initGame(lq.Space space) {
    space
      ..setIternation(iterations: 1)
      ..useSpatialHash(dim: 2, count: 10000);
  }

  @override
  void initState() {
    super.initState();
    _game = Game(widget.width, widget.height);
    _game.init(initGame);
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
          DotDraw(
            game: _game,
            width: widget.width,
            height: widget.height,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class DotDraw extends StatefulWidget {
  const DotDraw({super.key, required this.game, required this.width, required this.height});
  final Game game;
  final double width;
  final double height;

  @override
  State<DotDraw> createState() => _DotDrawState();
}

class _DotDrawState extends State<DotDraw> {
  var dShape = <_DotShape>[];
  var bShape = <_BulletShape>[];
  int imageWidth = 188;
  int imageHeight = 35;
  int imageRowLength = 24;
  final _random = Random();
  @override
  void initState() {
    super.initState();
    for (var x = 0; x < imageWidth; x++) {
      for (var y = 0; y < imageHeight; y++) {
        if (!getPixel(x, y)) continue;

        double xJitter = 0.05 * _random.nextDouble();
        double yJitter = 0.05 * _random.nextDouble();
        dShape.add(_DotShape(
            mass: 1, radius: 0.95, moment: double.infinity, color: Colors.white, space: widget.game.space, pos: mt.Vector2(2 * (x - imageWidth / 2 + xJitter), 2 * (imageHeight / 2 - y + yJitter))));
      }
    }

    bShape.add(_BulletShape(
      color: Colors.white,
      space: widget.game.space,
      pos: mt.Vector2(-1000, -10),
      mass: 1e9,
      radius: 8,
      moment: double.infinity,
      velocity: mt.Vector2(400, 0),
    ));

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  bool getPixel(int x, int y) {
    return (imageBitmap[(x >> 3) + y * imageRowLength] >> (~x & 0x7)) & 1 == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned.fill(
              child: InputW(
            game: widget.game,
            child: CustomPaint(
              painter: RenderPainter(
                game: widget.game,
                shapes: [...dShape, ...bShape],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class _BulletShape extends PaintShape {
  _BulletShape({
    required this.color,
    required this.space,
    required this.pos,
    required this.mass,
    required this.radius,
    required this.moment,
    required this.velocity,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: moment))
      ..setPosition(pos: pos)
      ..setVelocity(vel: velocity);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(0)
      ..setFriction(0)
      ..setFilter(notGrabbableFilter);
  }

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  final mt.Vector2 velocity;
  final double mass;
  final double radius;
  final double moment;
  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawPoints(
        PointMode.points,
        [Offset(body.getPosition().x, -body.getPosition().y)],
        Paint()
          ..color = Colors.white
          ..strokeWidth = radius);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _DotShape extends PaintShape {
  _DotShape({
    required this.color,
    required this.space,
    required this.pos,
    required this.mass,
    required this.radius,
    required this.moment,
  }) {
    var ball = makeBall(pos.x, pos.y);
    body = space.addBody(body: ball.getBody());
    space.addShape(shape: ball);
  }

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  final double mass;
  final double radius;
  final double moment;
  late lq.Body body;

  lq.Shape makeBall(double x, double y) {
    var body = lq.Body(mass: 1, moment: double.infinity)..setPosition(pos: mt.Vector2(x, y));
    return lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero())
      ..setElasticity(0)
      ..setFriction(0);
  }

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawPoints(
        PointMode.points,
        [Offset(body.getPosition().x, -body.getPosition().y)],
        Paint()
          ..color = Colors.white
          ..strokeWidth = radius);
    canvas.restore();
  }
}
