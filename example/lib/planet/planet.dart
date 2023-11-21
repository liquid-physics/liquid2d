import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Planet extends StatefulWidget {
  const Planet({super.key});
  static const route = '/planet';

  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PlanetLayoutSize(),
    );
  }
}

class PlanetLayoutSize extends StatelessWidget {
  const PlanetLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PlanetView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class PlanetView extends StatefulWidget {
  const PlanetView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<PlanetView> createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> {
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
          PlanetDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class PlanetDraw extends StatefulWidget {
  const PlanetDraw({super.key, required this.game});
  final Game game;
  @override
  State<PlanetDraw> createState() => _PlanetDrawState();
}

class _PlanetDrawState extends State<PlanetDraw> {
  late _PlanetShape planetBody;
  var asteroid = <_BoxAsteroidShape>[];
  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  @override
  void initState() {
    super.initState();
    widget.game.space.setIternation(iterations: 20);

    asteroid = [for (var i = 0; i < 30; i++) _BoxAsteroidShape(color: Colors.teal, space: widget.game.space, pos: randPos(10))];

    planetBody = _PlanetShape(color: Colors.lightBlue, radius: 70, space: widget.game.space, pos: mt.Vector2.zero());

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  mt.Vector2 randPos(double radius) {
    var v = mt.Vector2.zero();
    do {
      v = mt.Vector2(_random.nextDouble() * (640 - 2 * radius) - (320 - radius), _random.nextDouble() * (480 - 2 * radius) - (240 - radius));
    } while (v.length < 85);
    return v;
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
                shapes: [planetBody, ...asteroid],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PlanetShape extends PaintShape {
  _PlanetShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.KinematicBody())..setAngularVelocity(.2);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
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
    canvas.drawLine(Offset.zero, const Offset(50, 0), Paint()..color = Colors.white);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _BoxAsteroidShape extends PaintShape {
  _BoxAsteroidShape({
    required this.color,
    required this.space,
    required this.pos,
  }) {
    var mm = lq.Moment.forPoly(mass, verts, mt.Vector2.zero(), 0);
    body = space.addBody(body: lq.Body(mass: mass, moment: mm))
      ..setVelocityUpdateFunc((bodys, gravity, damping, dt) {
        var p = bodys.getPosition();
        var sqdist = p.dot(p);
        var g = p * (-gravityStrength / (sqdist * sqrt(sqdist)));
        bodys.updateVelocity(gravity: g, damping: damping, dt: dt);
      })
      ..setPosition(pos: pos);

    double r = pos.length;
    double v = sqrt(gravityStrength / r) / r;
    body
      ..setVelocity(vel: mt.Vector2(-pos.y, pos.x) * v)
      ..setAngularVelocity(v)
      ..setAngle(atan2(pos.y, pos.x));

    space.addShape(shape: lq.PolyShape(body: body, vert: verts, transform: Matrix4.identity(), radius: 0.0))
      ..setElasticity(0)
      ..setFriction(.7);
  }

  final verts = <mt.Vector2>[
    mt.Vector2(-size, -size),
    mt.Vector2(-size, size),
    mt.Vector2(size, size),
    mt.Vector2(size, -size),
  ];

  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;
  final double gravityStrength = 5.0e6;
  static double size = 10;
  double mass = 4;
  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in verts) Offset(ele.x + body.getPosition().x, -ele.y + -body.getPosition().y)]),
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
