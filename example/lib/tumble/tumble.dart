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

class Tumble extends StatefulWidget {
  static const route = '/tumble';
  const Tumble({super.key});

  @override
  State<Tumble> createState() => _TumbleState();
}

class _TumbleState extends State<Tumble> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const TumbleLayoutSize(),
    );
  }
}

class TumbleLayoutSize extends StatelessWidget {
  const TumbleLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TumbleView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class TumbleView extends StatefulWidget {
  const TumbleView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<TumbleView> createState() => _TumbleViewState();
}

class _TumbleViewState extends State<TumbleView> {
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
        TumbleDraw(
          game: _game,
        ),
        FpsCounter(
          renderUpdate: _game.renderUpdate.stream,
        )
      ]),
    );
  }
}

class TumbleDraw extends StatefulWidget {
  const TumbleDraw({super.key, required this.game});
  final Game game;
  @override
  State<TumbleDraw> createState() => _TumbleDrawState();
}

class _TumbleDrawState extends State<TumbleDraw> {
  var box = <_TerrainShape>[];
  var shape = <PaintShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space.setGravity(gravity: mt.Vector2(0, -600));
    lq.Body kinematicBody = widget.game.space.addBody(body: lq.KinematicBody())..setAngularVelocity(.4);

    var a = mt.Vector2(-200, -200);
    var b = mt.Vector2(-200, 200);
    var c = mt.Vector2(200, 200);
    var d = mt.Vector2(200, -200);

    box = [
      _TerrainShape(space: widget.game.space, body: kinematicBody, color: Colors.white, a: a, b: b),
      _TerrainShape(space: widget.game.space, body: kinematicBody, color: Colors.white, a: b, b: c),
      _TerrainShape(space: widget.game.space, body: kinematicBody, color: Colors.white, a: c, b: d),
      _TerrainShape(space: widget.game.space, body: kinematicBody, color: Colors.white, a: d, b: a),
    ];

    shape = [
      for (var i = 0; i < 10; i++) ...[
        _CircleShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), radius: 20, space: widget.game.space, pos: mt.Vector2.zero()),
        _BoxShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 40, height: 80, space: widget.game.space, pos: mt.Vector2.zero()),
        _BoxCircleShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 30, height: 60, space: widget.game.space, pos: mt.Vector2.zero())
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
                shapes: [...box, ...shape],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TerrainShape extends PaintShape {
  _TerrainShape({required this.space, required this.color, required this.body, required this.a, required this.b}) {
    space.addShape(shape: lq.SegmentShape(body: body, a: a, b: b, radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
  }
  final lq.Space space;
  final Color color;
  final mt.Vector2 a;
  final mt.Vector2 b;

  final lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: 0, cy: 0, angle: -body.getAngle());
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 1);
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

class _BoxCircleShape extends PaintShape {
  _BoxCircleShape({
    required this.color,
    required this.width,
    required this.height,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 1, moment: lq.Moment.forBox(1, width, height)))..setPosition(pos: pos);

    space.addShape(shape: lq.SegmentShape(body: body, a: mt.Vector2(0, 15), b: mt.Vector2(0, -15), radius: 15))
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
    canvas.drawLine(
        Offset(0 + body.getPosition().x, 15 - body.getPosition().y),
        Offset(0 + body.getPosition().x, -15 - body.getPosition().y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 30);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
