// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Buoyancy extends StatefulWidget {
  const Buoyancy({super.key});
  static const route = '/buoyancy';

  @override
  State<Buoyancy> createState() => _BuoyancyState();
}

class _BuoyancyState extends State<Buoyancy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const BuoyancyLayoutSize(),
    );
  }
}

class BuoyancyLayoutSize extends StatelessWidget {
  const BuoyancyLayoutSize({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => BuoyancyView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class BuoyancyView extends StatefulWidget {
  const BuoyancyView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<BuoyancyView> createState() => _BuoyancyViewState();
}

class _BuoyancyViewState extends State<BuoyancyView> {
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
          BuoyancyDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class BuoyancyDraw extends StatefulWidget {
  const BuoyancyDraw({super.key, required this.game});
  final Game game;

  @override
  State<BuoyancyDraw> createState() => _BuoyancyDrawState();
}

class _BuoyancyDrawState extends State<BuoyancyDraw> {
  var segmentLine = <_SegmentShape>[];
  late _WaterShape water;
  var box = <_BoxShape>[];

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -500))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);

    var staticBody = widget.game.space.getStaticBody();
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];

    var rb = lq.Rect.fromLBRT(-300, -200, 100, 0);

    segmentLine = [
      ...segmentLine,
      _SegmentShape(color: Colors.white, radius: 5, space: widget.game.space, posA: mt.Vector2(rb.left, rb.bottom), posB: mt.Vector2(rb.left, rb.top), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 5, space: widget.game.space, posA: mt.Vector2(rb.right, rb.bottom), posB: mt.Vector2(rb.right, rb.top), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 5, space: widget.game.space, posA: mt.Vector2(rb.left, rb.bottom), posB: mt.Vector2(rb.right, rb.bottom), staticBody: staticBody),
    ];
    water = _WaterShape(color: Colors.white, radius: 0, space: widget.game.space, rect: rb, staticBody: staticBody);
    box = [
      _BoxShape(color: Colors.purpleAccent, width: 200, height: 50, space: widget.game.space, pos: mt.Vector2(-50, -100)),
      _BoxShape(color: Colors.blueAccent, width: 40, height: 80, space: widget.game.space, pos: mt.Vector2(-200, -50)),
    ];

    widget.game.space.addCollisionHandler(aType: 1, bType: 0).preSolve((arbiter, space) {
      var (lq.Shape water, lq.Shape poly) = arbiter.getShapes();
      var body = poly.getBody();
      var level = water.getRect().top;
      var count = (poly as lq.BoxShape).getCount();
      var clipped = <mt.Vector2>[];

      for (int i = 0, j = count - 1; i < count; j = i, i++) {
        mt.Vector2 a = body.localToWorld(poly.getVert(j));
        mt.Vector2 b = body.localToWorld(poly.getVert(i));

        if (a.y < level) {
          clipped.add(a);
        }

        double a_level = a.y - level;
        double b_level = b.y - level;

        if (a_level * b_level < 0.0) {
          double t = a_level.abs() / (a_level.abs() + b_level.abs());
          clipped.add(mt.Vector2(lerpDouble(a.x, b.x, t) ?? 0, lerpDouble(a.y, b.y, t) ?? 0));
        }
      }
      double clippedArea = lq.Area.forPoly(clipped, 0);
      double displacedMass = clippedArea * .00014;
      mt.Vector2 centroid = lq.Centeroid.forPoly(clipped);

      double dt = widget.game.space.getCurrentTimeStep();
      mt.Vector2 g = widget.game.space.getGravity();

      // Apply the buoyancy force as an impulse.
      body.applyImpulseAtWorldPoint(impulse: g * -displacedMass * dt, point: centroid);

      // Apply linear damping for the fluid drag.
      mt.Vector2 v_centroid = body.getVelocityAtWorldPoint(point: centroid);
      double rcn = (centroid - body.getPosition()).cross(v_centroid.normalized());

      double k = 1.0 / body.getMass() + rcn * rcn / body.getMoment();

      double damping = clippedArea * 2.0 * .00014;
      double v_coef = exp(-damping * dt * k); // linear drag
      body.applyImpulseAtWorldPoint(impulse: ((v_centroid * v_coef) - v_centroid) * 1 / k, point: centroid);

      mt.Vector2 cog = body.localToWorld(body.getCenterOfGravity());
      double w_damping = lq.Moment.forPoly(2.0 * .00014 * clippedArea, clipped, cog..negate(), 0);
      body.setAngularVelocity(body.getAngularVelocity() * exp(-w_damping * dt / body.getMoment()));
      return true;
    });

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
                shapes: [...segmentLine, water, ...box],
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

class _WaterShape extends PaintShape {
  _WaterShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.rect,
    required this.staticBody,
  }) {
    space.addShape(shape: lq.BoxShape.fromRect(body: staticBody, rect: rect, radius: radius))
      ..setSensor(true)
      ..setCollisionType(1);
  }
  final double radius;
  final Color color;
  final lq.Space space;
  final lq.Body staticBody;
  final Rect rect;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawRRect(
        RRect.fromRectAndRadius(lq.Rect.fromLBRT(rect.left, -rect.bottom, rect.right, -rect.top), Radius.circular(radius)),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke);

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
    body = space.addBody(body: lq.Body(mass: .00014 * .3 * width * height, moment: lq.Moment.forBox(.00014 * .3 * width * height, width, height)))
      ..setPosition(pos: pos)
      ..setVelocity(vel: mt.Vector2(0, -100))
      ..setAngularVelocity(1);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0)).setFriction(.8);
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
