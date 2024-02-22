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

class Sticky extends StatefulWidget {
  const Sticky({super.key});
  static const route = '/Sticky';
  @override
  State<Sticky> createState() => _StickyState();
}

class _StickyState extends State<Sticky> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const StickyLayoutSize(),
    );
  }
}

class StickyLayoutSize extends StatelessWidget {
  const StickyLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => StickyView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class StickyView extends StatefulWidget {
  const StickyView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<StickyView> createState() => _StickyViewState();
}

class _StickyViewState extends State<StickyView> {
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
          StickyDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class StickyDraw extends StatefulWidget {
  const StickyDraw({super.key, required this.game});
  final Game game;

  @override
  State<StickyDraw> createState() => _StickyDrawState();
}

class _StickyDrawState extends State<StickyDraw> {
  var shp = <PaintShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 10)
      ..setGravity(gravity: mt.Vector2(0, -1000))
      ..setCollisionSlop(collisionSlop: 2);

    var staticBody = widget.game.space.getStaticBody();

    shp = [
      _SegmentShape(color: Colors.white, radius: 20, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 20, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 20, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 20, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
    ];

    for (var i = 0; i < 200; i++) {
      shp.add(_CircleShape(
          color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          radius: 10,
          space: widget.game.space,
          pos: mt.Vector2(lerpDouble(-150, 150, _random.nextDouble()) ?? 0, lerpDouble(-150, 150, _random.nextDouble()) ?? 0)));
    }
    widget.game.space.addWildcardHandler(type: 1)
      ..preSolve((arbiter, space) {
        // We want to fudge the collisions a bit to allow shapes to overlap more.
        // This simulates their squishy sticky surface, and more importantly
        // keeps them from separating and destroying the joint.

        // Track the deepest collision point and use that to determine if a rigid collision should occur.
        var deepest = double.infinity;

        // Grab the contact set and iterate over them.
        var contacts = arbiter.getContactPointSet();
        for (int i = 0; i < contacts.count; i++) {
          // Sink the contact points into the surface of each shape.
          contacts.points[i] = contacts.points[i].copyWith(
            pointA: contacts.points[i].pointA - (contacts.normal * _stickSensorThickness),
            pointB: contacts.points[i].pointB + (contacts.normal * _stickSensorThickness),
          );

          deepest = min(deepest, contacts.points[i].distance) + 2 * _stickSensorThickness;
        }
        // Set the new contact point data.
        arbiter.setContactPointSet(contacts);
        // If the shapes are overlapping enough, then create a
        // joint that sticks them together at the first contact point.
        if (arbiter.getData<lq.Constraint>() == null && deepest <= 0.0) {
          var (lq.Body bodyA, lq.Body bodyB) = arbiter.getBodies();

          // Create a joint at the contact point to hold the body in place.
          var anchorA = bodyA.worldToLocal(contacts.points[0].pointA);
          var anchorB = bodyB.worldToLocal(contacts.points[0].pointB);

          // Give it a finite force for the stickyness.
          var joint = lq.PivotJoint(a: bodyA, b: bodyB, anchorA: anchorA, anchorB: anchorB)..setMaxForce(3e3);

          //Schedule a post-step() callback to add the joint.
          space.addPostStepCallback<lq.Constraint>(joint, (space, liquid2dType) {
            space.addConstraint(constraint: liquid2dType);
          });

          arbiter.setData<lq.Constraint>(joint);
          //print(Called.count++);

          // Store the joint on the arbiter so we can remove it later.
        }
        // Position correction and velocity are handled separately so changing
        // the overlap distance alone won't prevent the collision from occuring.
        // Explicitly the collision for this frame if the shapes don't overlap using the new distance.
        return (deepest <= 0.0);

        // Lots more that you could improve upon here as well:
        // * Modify the joint over time to make it plastic.
        // * Modify the joint in the post-step to make it conditionally plastic (like clay).
        // * Track a joint for the deepest contact point instead of the first.
        // * Track a joint for each contact point. (more complicated since you only get one data pointer).
      })
      ..separate((arbiter, space) {
        var joint = arbiter.getData<lq.Constraint>();

        if (joint != null) {
          // The joint won't be removed until the step is done.
          // Need to disable it so that it won't apply itself.
          // Setting the force to 0 will do just that
          joint.setMaxForce(0);

          // Perform the removal in a post-step() callback.
          space.addPostStepCallback<lq.Constraint>(joint, (space, liquid2dType) {
            space.removeConstraint(constraint: liquid2dType);
          });
          arbiter.removeData();
        }
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
                shapes: [...shp],
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

class _CircleShape extends PaintShape {
  _CircleShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: .15, moment: lq.Moment.forCircle(.15, 0.0, radius, mt.Vector2.zero())))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius + _stickSensorThickness, offset: mt.Vector2.zero()))
      ..setFriction(.9)
      ..setCollisionType(1);
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
    canvas.drawCircle(Offset(body.getPosition().x, -body.getPosition().y), radius + _stickSensorThickness, Paint()..color = color);
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

var _stickSensorThickness = 2.5;
