import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_example/bouncy_hexagon/terrrain_data.dart';
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;
import 'package:liquid/liquid.dart' as lq;

class BouncyHexagon extends StatefulWidget {
  static const route = '/bouncy-hexagon';
  const BouncyHexagon({super.key});

  @override
  State<BouncyHexagon> createState() => _BouncyHexagonState();
}

class _BouncyHexagonState extends State<BouncyHexagon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const BouncyHexagonLayoutSize(),
    );
  }
}

class BouncyHexagonLayoutSize extends StatelessWidget {
  const BouncyHexagonLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => BouncyHexagonView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class BouncyHexagonView extends StatefulWidget {
  const BouncyHexagonView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<BouncyHexagonView> createState() => _BouncyHexagonViewState();
}

class _BouncyHexagonViewState extends State<BouncyHexagonView> {
  late final Game _game;

  @override
  void dispose() {
    _game.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _game = Game(widget.width, widget.height);
    _game.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(children: [
          BouncyHexagonDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class BouncyHexagonDraw extends StatefulWidget {
  const BouncyHexagonDraw({super.key, required this.game});
  final Game game;

  @override
  State<BouncyHexagonDraw> createState() => _BouncyHexagonDrawState();
}

class _BouncyHexagonDrawState extends State<BouncyHexagonDraw> {
  var hexagon = <_HexagonShape>[];
  var terrain = <_TerrainShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space.setIternation(iterations: 10);

    var offset = mt.Vector2(-320, -240);
    terrain = [for (var i = 0; i < terrainData.length - 1; i++) _TerrainShape(space: widget.game.space, color: Colors.white, a: terrainData[i] + offset, b: terrainData[i + 1] + offset)];

    hexagon = [for (var i = 0; i < 500; i++) _HexagonShape(space: widget.game.space, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0))];

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
                shapes: [...terrain, ...hexagon],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TerrainShape extends PaintShape {
  _TerrainShape({required this.space, required this.color, required this.a, required this.b}) {
    space.addShape(shape: lq.SegmentShape(body: space.getStaticBody(), a: a, b: b, radius: 0)).setElasticity(1);
  }
  final lq.Space space;
  final Color color;
  final mt.Vector2 a;
  final mt.Vector2 b;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 1);
    canvas.restore();
  }
}

class _HexagonShape extends PaintShape {
  _HexagonShape({
    required this.space,
    required this.color,
  }) {
    body = space.addBody(body: lq.Body(mass: radius * radius, moment: moment))
      ..setPosition(pos: mt.Vector2(next(-1, 1), next(-1, 1)) * 130)
      ..setVelocity(vel: mt.Vector2(next(0, 1), next(0, 1)) * 50);

    space.addShape(shape: lq.PolyShape(body: body, vert: _hexagon, transform: Matrix4.identity(), radius: 1)).setElasticity(1);
  }
  final lq.Space space;
  late lq.Body body;
  final Color color;

  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  static final _hexagon = <mt.Vector2>[
    for (int i = 0; i < 6; i++) mt.Vector2(cos(-pi * 2.0 * i / 6.0), sin(-pi * 2.0 * i / 6.0)) * (5 - 1),
  ];
  static double moment = lq.Moment.forPoly(radius * radius, _hexagon, mt.Vector2.zero(), 0);
  static double radius = 5;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in _hexagon) Offset(ele.x + body.getPosition().x, -ele.y + -body.getPosition().y)]),
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
