import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;
import 'package:liquid2d/liquid2d.dart' as lq;

class Plink extends StatefulWidget {
  static const route = '/plink';
  const Plink({super.key});

  @override
  State<Plink> createState() => _PlinkState();
}

class _PlinkState extends State<Plink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PlinkLayoutSize(),
    );
  }
}

class PlinkLayoutSize extends StatelessWidget {
  const PlinkLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PlinkView(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      ),
    );
  }
}

class PlinkView extends StatefulWidget {
  const PlinkView({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<PlinkView> createState() => _PlinkViewState();
}

class _PlinkViewState extends State<PlinkView> {
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
        PlinkDraw(game: _game),
        FpsCounter(
          renderUpdate: _game.renderUpdate.stream,
        )
      ]),
    );
  }
}

class PlinkDraw extends StatefulWidget {
  const PlinkDraw({super.key, required this.game});
  final Game game;
  @override
  State<PlinkDraw> createState() => _PlinkDrawState();
}

class _PlinkDrawState extends State<PlinkDraw> {
  var triangle = <_TriangleShape>[];
  var circle = <_CircleShape>[];
  var pentagon = <_PentagonShape>[];
  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  @override
  void initState() {
    super.initState();
    late lq.Body body;

    widget.game.space
      ..setIternation(iterations: 5)
      ..setGravity(gravity: mt.Vector2(0, -100));
    body = widget.game.space.getStaticBody();

    triangle = [
      for (var i = 0; i < 9; i++)
        for (var j = 0; j < 9; j++) ...[
          _TriangleShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), space: widget.game.space, body: body, pos: mt.Vector2(i * 80 - 320 + (j % 2) * 40, j * 70 - 240))
          //pos: mt.Vector2(i * 50, j * 50)),
        ]
    ];
    circle = [_CircleShape(color: Colors.red, radius: 10, space: widget.game.space, pos: mt.Vector2(2, 300))];

    pentagon = [for (int i = 0; i < 300; i++) _PentagonShape(space: widget.game.space, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0))];

    widget.game.renderUpdate.stream.listen((event) {
      widget.game.space.eachBody((body) {
        mt.Vector2 pos = (body).getPosition();
        if (pos.y < -260 || (pos.x).abs() > 340) {
          body.setPosition(pos: mt.Vector2(next(-320, 320), 350));
        }
      });
      setState(() {});
    });
  }

  void rightClick(details) {
    var (lq.Shape sh, _) = widget.game.space.pointQueryNearest(mouse: widget.game.spaceMatrix.mouseToView(details.localPosition), radius: 0, filter: grabFilter);
    if (sh.isExist) {
      lq.Body body = sh.getBody();
      if (body.getType() == lq.BodyType.static) {
        body.setType(lq.BodyType.dynamic);
        body.setMass(_PentagonShape.mass);
        body.setMoment(_PentagonShape.moment);
      } else if (body.getType() == lq.BodyType.dynamic) {
        body.setType(lq.BodyType.static);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InputW(
            onSecondaryTapDown: rightClick,
            onDoubleTapDown: rightClick,
            game: widget.game,
            child: CustomPaint(
              painter: RenderPainter(
                game: widget.game,
                shapes: [...triangle, ...circle, ...pentagon],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PentagonShape extends PaintShape {
  _PentagonShape({
    required this.space,
    required this.color,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: moment))..setPosition(pos: mt.Vector2(next(-320, 320), 350));

    space.addShape(shape: lq.PolyShape(body: body, vert: _pentagon, transform: Matrix4.identity(), radius: 0))
      ..setElasticity(0)
      ..setFriction(0.4);
  }
  final lq.Space space;
  late lq.Body body;
  final Color color;

  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  static final _pentagon = <mt.Vector2>[
    for (int i = 0; i < 5; i++) mt.Vector2(10 * cos(-2.0 * pi * i / 5), 10 * sin(-2.0 * pi * i / 5)),
  ];
  static double mass = 1;
  static double moment = lq.Moment.forPoly(1, _pentagon, mt.Vector2.zero(), 0);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in _pentagon) Offset(ele.x + body.getPosition().x, -ele.y + -body.getPosition().y)]),
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

class _TriangleShape extends PaintShape {
  _TriangleShape({required this.color, required this.space, required this.pos, required this.body}) {
    shape = space.addShape(shape: lq.PolyShape(body: body, vert: _triangle, transform: Matrix4.identity()..translate(pos.x, -pos.y), radius: 0.0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
  }
  final _triangle = <mt.Vector2>[
    mt.Vector2(-15, -15),
    mt.Vector2(0, 10),
    mt.Vector2(15, -15),
  ];

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  late lq.Shape shape;
  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawVertices(
        Vertices(VertexMode.triangles, [for (var ele in _triangle) Offset(ele.x + pos.x, -ele.y + pos.y)]),
        BlendMode.dst,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color);
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
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
