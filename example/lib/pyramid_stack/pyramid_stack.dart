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

class PyramidStack extends StatefulWidget {
  static const route = '/pyramidstack';
  const PyramidStack({super.key});

  @override
  State<PyramidStack> createState() => _PyramidStackState();
}

class _PyramidStackState extends State<PyramidStack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PyramidStackLayoutSize(),
    );
  }
}

class PyramidStackLayoutSize extends StatelessWidget {
  const PyramidStackLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PyramidStackView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class PyramidStackView extends StatefulWidget {
  const PyramidStackView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<PyramidStackView> createState() => _PyramidStackViewState();
}

class _PyramidStackViewState extends State<PyramidStackView> {
  late final Game _game;

  void initGame(lq.Space space) {
    space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -100))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);
    var staticBody = space.getStaticBody();
    space.addShape(shape: lq.SegmentShape(body: staticBody, a: mt.Vector2(-widget.width / 2, -widget.height / 2), b: mt.Vector2(-widget.width / 2, widget.height / 2), radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
    space.addShape(shape: lq.SegmentShape(body: staticBody, a: mt.Vector2(widget.width / 2, -widget.height / 2), b: mt.Vector2(widget.width / 2, widget.height / 2), radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);

    space.addShape(shape: lq.SegmentShape(body: staticBody, a: mt.Vector2(-widget.width / 2, -widget.height / 2), b: mt.Vector2(widget.width / 2, -widget.height / 2), radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
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
          StackDraw(
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

class StackDraw extends StatefulWidget {
  const StackDraw({super.key, required this.game, required this.width, required this.height});
  final Game game;
  final double width;
  final double height;
  @override
  State<StackDraw> createState() => _StackDrawState();
}

class _StackDrawState extends State<StackDraw> {
  var cShape = <_CircleShape>[];
  var bShape = <_BoxShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();

    // draw dynamic body
    cShape = [_CircleShape(color: Colors.red, radius: 15, space: widget.game.space, pos: mt.Vector2(0, -240 + 15 + 5))];

    bShape = [
      for (int i = 0; i < 14; i++)
        for (int j = 0; j <= i; j++) ...[
          _BoxShape(space: widget.game.space, pos: mt.Vector2(j * 32 - i * 16, 300 - i * 32), color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 30, height: 30)
        ]
    ];

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
              shapes: [...cShape, ...bShape],
            ),
          ),
        ))
      ],
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
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
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
    body = space.addBody(body: lq.Body(mass: 1, moment: lq.Moment.forBox(1, width, height)))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))
      ..setElasticity(0)
      ..setFriction(.8);
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
