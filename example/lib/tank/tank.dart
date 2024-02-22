// ignore_for_file: unused_element

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

class Tank extends StatefulWidget {
  const Tank({super.key});
  static const route = '/tank';
  @override
  State<Tank> createState() => _TankState();
}

class _TankState extends State<Tank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const TankLayoutSize(),
    );
  }
}

class TankLayoutSize extends StatelessWidget {
  const TankLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TankView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class TankView extends StatefulWidget {
  const TankView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<TankView> createState() => _TankViewState();
}

class _TankViewState extends State<TankView> {
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
          TankDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class TankDraw extends StatefulWidget {
  const TankDraw({super.key, required this.game});
  final Game game;
  @override
  State<TankDraw> createState() => _TankDrawState();
}

class _TankDrawState extends State<TankDraw> {
  var segmentLine = <_SegmentShape>[];
  var box = <_BoxShape>[];
  var tank = <_BoxShape>[];
  late lq.Body tankBody;
  final _random = Random();
  var mouse = mt.Vector2.zero();
  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 10)
      ..setSleepTimeThreshold(sleepTimeThreshold: .5);
    var staticBody = widget.game.space.getStaticBody();
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];
    var rad = mt.Vector2(20, 20).length;

    for (var i = 0; i < 50; i++) {
      var bd = _BoxShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          width: 20,
          height: 20,
          space: widget.game.space,
          pos: mt.Vector2(_random.nextDouble() * (640 - 2 * rad) - (320 - rad), _random.nextDouble() * (480 - 2 * rad) - (240 - rad)));
      widget.game.space.addConstraint(constraint: lq.PivotJoint(a: staticBody, b: bd.body, anchorA: mt.Vector2.zero(), anchorB: mt.Vector2.zero()))
        ..setMaxBias(0)
        ..setMaxForce(1000);
      widget.game.space.addConstraint(constraint: lq.GearJoint(a: staticBody, b: bd.body, phase: 0, ratio: 1))
        ..setMaxBias(0)
        ..setMaxForce(5000);

      box.add(bd);
    }

    tankBody = widget.game.space.addBody(body: lq.KinematicBody());
    var bs = _BoxShape(
        color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        width: 30,
        height: 30,
        mass: 10,
        space: widget.game.space,
        pos: mt.Vector2(_random.nextDouble() * (640 - 2 * rad) - (320 - rad), _random.nextDouble() * (480 - 2 * rad) - (240 - rad)));

    tank = [bs];
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: tankBody, b: bs.body, anchorA: mt.Vector2.zero(), anchorB: mt.Vector2.zero()))
      ..setMaxBias(0)
      ..setMaxForce(10000);
    widget.game.space.addConstraint(constraint: lq.GearJoint(a: tankBody, b: bs.body, phase: 0, ratio: 1))
      ..setErrorBias(0)
      ..setMaxBias(1.2)
      ..setMaxForce(50000);

    widget.game.physicUpdateBefore = (p0) {
      var delta = mouse - bs.body.getPosition();
      var turn = toAngle(unRotate(bs.body.getRotation(), delta));
      tankBody.setAngle(bs.body.getAngle() - turn);
      if (isNear(mouse, bs.body.getPosition(), 30)) {
        tankBody.setVelocity(vel: mt.Vector2.zero());
      } else {
        var direction = delta.dot(bs.body.getRotation()) > 0 ? 1.0 : -1.0;
        tankBody.setVelocity(vel: rotate(bs.body.getRotation(), mt.Vector2(30 * direction, 0)));
      }
    };

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  mt.Vector2 unRotate(mt.Vector2 v1, mt.Vector2 v2) {
    return mt.Vector2(v1.x * v2.x + v1.y * v2.y, v1.y * v2.x - v1.x * v2.y);
  }

  mt.Vector2 rotate(mt.Vector2 v1, mt.Vector2 v2) {
    return mt.Vector2(v1.x * v2.x - v1.y * v2.y, v1.x * v2.y + v1.y * v2.x);
  }

  double toAngle(mt.Vector2 v) {
    return atan2(v.y, v.x);
  }

  bool isNear(mt.Vector2 a, mt.Vector2 b, double distance) => (a - b).length2 < distance * distance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerHover: (event) {
              mouse = widget.game.spaceMatrix.mouseToView(Offset(event.localPosition.dx, event.localPosition.dy));
            },
            child: InputW(
              game: widget.game,
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: [...segmentLine, ...box, ...tank],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TankBody extends PaintShape {
  @override
  void draw(Canvas canvas, Size size) {}
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
    required this.width,
    required this.height,
    required this.space,
    required this.pos,
    this.mass = 1,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: lq.Moment.forBox(mass, width, height)))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))
      ..setElasticity(0)
      ..setFriction(.7);
  }
  final double mass;
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
