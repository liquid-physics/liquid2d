// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class Player extends StatefulWidget {
  const Player({super.key});
  static const route = '/player';

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PlayerLayoutSize(),
    );
  }
}

class PlayerLayoutSize extends StatelessWidget {
  const PlayerLayoutSize({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PlayerView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class PlayerView extends StatefulWidget {
  const PlayerView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
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
          PlayerDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class PlayerDraw extends StatefulWidget {
  const PlayerDraw({super.key, required this.game});
  final Game game;

  @override
  State<PlayerDraw> createState() => _PlayerDrawState();
}

class _PlayerDrawState extends State<PlayerDraw> {
  var segmentLine = <_SegmentShape>[];
  late _PlayerShape playerShape;
  var box = <_BoxShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 10)
      ..setGravity(gravity: mt.Vector2(0, -2000));
    var staticBody = widget.game.space.getStaticBody();
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];
    var y = 0;
    var x = 0;
    var grounded = false;
    var remainingBoost = 0.0;

    playerShape = _PlayerShape(
      color: Colors.blueAccent,
      width: 30,
      height: 55,
      space: widget.game.space,
      pos: mt.Vector2(0, -200),
      velocityFunc: (body, gravity, damping, dt) {
        bool jumpState = y > 0;

        // Grab the grounding normal from last frame
        var groundNormal = mt.Vector2.zero();
        playerShape.body.eachArbiter(
          (body, arbiter) {
            var n = arbiter.getNormal()..negate();

            if (n.y > groundNormal.y) {
              groundNormal = n;
            }
          },
        );

        grounded = (groundNormal.y > 0.0);
        if (groundNormal.y < 0.0) remainingBoost = 0.0;

        // Do a normal-ish update
        bool boost = (jumpState && remainingBoost > 0.0);
        var g = (boost ? mt.Vector2.zero() : gravity);
        body.updateVelocity(gravity: g, damping: damping, dt: dt);

        // Target horizontal speed for air/ground control
        double target_vx = 500.0 * x;

        // Update the surface velocity and friction
        // Note that the "feet" move in the opposite direction of the player.
        var surface_v = mt.Vector2(-target_vx, 0.0);
        playerShape.shape.setSurfaceVelocity(surface_v);
        playerShape.shape.setFriction(grounded ? 500 / 0.1 / 2000 : 0.0);

        // Apply air control if not grounded
        if (!grounded) {
          // Smoothly accelerate the velocity
          playerShape.body.setVelocity(vel: mt.Vector2(lerpConst(playerShape.body.getVelocity().x, target_vx, 500 / 0.25 * dt), playerShape.body.getVelocity().y));
        }
        body.setVelocity(vel: mt.Vector2(body.getVelocity().x, clampDouble(body.getVelocity().y, -900, double.infinity)));
      },
    );
    box = [
      for (var i = 0; i < 5; i++)
        for (var j = 0; j < 3; j++)
          _BoxShape(color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), width: 50, height: 50, space: widget.game.space, pos: mt.Vector2(100 + j * 60, -200 + i * 60))
    ];
    widget.game.keyboardUpdate = ((event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) y = 1;
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) x = -1;
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) x = 1;
      }
      if (event is KeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp || event.logicalKey == LogicalKeyboardKey.arrowLeft || event.logicalKey == LogicalKeyboardKey.arrowRight) {
          y = 0;
          x = 0;
        }
      }
    });
    var lastJumpState = false;
    var jumpStated = false;
    widget.game.physicUpdateBefore = (p0) {
      jumpStated = (y > 0.0);

      // If the jump key was just pressed this frame, jump!
      if (jumpStated && !lastJumpState && grounded) {
        double jump_v = sqrt(2.0 * 50 * 900);
        playerShape.body.setVelocity(vel: playerShape.body.getVelocity() + mt.Vector2(0, jump_v));

        remainingBoost = 55 / jump_v;
      }
    };

    widget.game.physicUpdateAfter = (p0) {
      remainingBoost -= p0;
      lastJumpState = jumpStated;
    };
    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  double lerpConst(double f1, double f2, double d) {
    return f1 + clampDouble(f2 - f1, -d, d);
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
                shapes: [...segmentLine, playerShape, ...box],
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

class _PlayerShape extends PaintShape {
  _PlayerShape({
    required this.color,
    required this.width,
    required this.height,
    required this.space,
    required this.pos,
    required this.velocityFunc,
  }) {
    body = space.addBody(body: lq.Body(mass: 1, moment: double.infinity))
      ..setPosition(pos: pos)
      ..setVelocity(vel: mt.Vector2(0, -100))
      ..setVelocityUpdateFunc(velocityFunc);
    shape = space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 10))
      ..setFriction(0)
      ..setElasticity(0)
      ..setCollisionType(1);
  }

  final double width;
  final double height;
  final Color color;
  final lq.Space space;
  late lq.Shape shape;
  final mt.Vector2 pos;
  final void Function(lq.Body, mt.Vector2, double, double) velocityFunc;
  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: width + 20, height: height + 20), const Radius.circular(10)),
        Paint()..color = color);
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
    body = space.addBody(body: lq.Body(mass: 4, moment: double.infinity))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))
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

    canvas.drawRect(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: width, height: height), Paint()..color = color);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
