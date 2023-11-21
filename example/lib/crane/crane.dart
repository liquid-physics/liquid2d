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

class Crane extends StatefulWidget {
  const Crane({super.key});
  static const route = '/crane';

  @override
  State<Crane> createState() => _CraneState();
}

class _CraneState extends State<Crane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const CraneLayoutSize(),
    );
  }
}

class CraneLayoutSize extends StatelessWidget {
  const CraneLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CraneView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class CraneView extends StatefulWidget {
  const CraneView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<CraneView> createState() => _CraneViewState();
}

class _CraneViewState extends State<CraneView> {
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
          CraneDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class CraneDraw extends StatefulWidget {
  const CraneDraw({super.key, required this.game});
  final Game game;

  @override
  State<CraneDraw> createState() => _CraneDrawState();
}

class _CraneDrawState extends State<CraneDraw> {
  late _SegmentShape line;
  late _GrooveShape gro;
  late _DollyShape dolly;
  late _HookShape hook;
  late _SlideShape slide;
  late _BoxShape box;
  lq.Constraint? hookJoint;
  var mouse = mt.Vector2.zero();
  @override
  void initState() {
    super.initState();

    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -100))
      ..setDamping(damping: .8);

    var staticBody = widget.game.space.getStaticBody();
    line = _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody);
    dolly = _DollyShape(color: Colors.blueAccent, width: 30, height: 30, space: widget.game.space, pos: mt.Vector2(0, 100));
    gro = _GrooveShape(color: Colors.green, a: staticBody, b: dolly.body, space: widget.game.space);
    var pv = widget.game.space.addConstraint(constraint: lq.PivotJoint(a: staticBody, b: dolly.body, anchorA: mt.Vector2.zero(), anchorB: dolly.body.getPosition()))
      ..setMaxForce(10000)
      ..setMaxBias(100);
    hook = _HookShape(color: Colors.purpleAccent, radius: 10, space: widget.game.space, pos: mt.Vector2(0, 50));
    slide = _SlideShape(color: Colors.green, space: widget.game.space, a: dolly.body, b: hook.body);

    box = _BoxShape(color: Colors.redAccent, width: 50, height: 50, space: widget.game.space, pos: mt.Vector2(200, -200));

    widget.game.space.addCollisionHandler(aType: 1, bType: 2).begin((arbiter, space) {
      if (hookJoint == null) {
        var (lq.Body a, lq.Body b) = arbiter.getBodies();

        widget.game.space.addPostStepCallback<lq.Space>(space, (space, liquidType) {
          hookJoint = space.addConstraint(constraint: lq.PivotJoint(a: a, b: b, anchorA: a.worldToLocal(a.getPosition()), anchorB: b.worldToLocal(a.getPosition())));
        });
      }

      return true; // return value is ignored for sensor callbacks anyway
    });

    widget.game.physicUpdateBefore = (p0) {
      pv.setAnchorA(mt.Vector2(mouse.x, 100));
      slide.constraint.setMax(max(100 - mouse.y, 50));
    };

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

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
              onSecondaryTapDown: (p0) {
                if (hookJoint != null) {
                  widget.game.space.removeConstraint(constraint: hookJoint!);
                  hookJoint!.destroy();
                  hookJoint = null;
                }
              },
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: [line, dolly, hook, slide, gro, box],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SlideShape extends PaintShape {
  _SlideShape({
    required this.color,
    required this.space,
    required this.a,
    required this.b,
  }) {
    constraint = space.addConstraint(constraint: lq.SlideJoint(a: a, b: b, anchorA: mt.Vector2.zero(), anchorB: mt.Vector2.zero(), min: 0, max: double.infinity))
      ..setMaxForce(30000)
      ..setMaxBias(60);
  }
  final Color color;
  final lq.Space space;
  final lq.Body a;
  final lq.Body b;
  late lq.SlideJoint constraint;

  var aC = mt.Vector2.zero();
  var bC = mt.Vector2.zero();
  @override
  void draw(Canvas canvas, Size size) {
    aC = constraint.a.transform.toTransformPoint((constraint).getAnchorA());
    bC = constraint.b.transform.toTransformPoint((constraint).getAnchorB());
    canvas.drawCircle(Offset(aC.x, -aC.y), 5, Paint()..color = Colors.green);
    canvas.drawCircle(Offset(bC.x, -bC.y), 5, Paint()..color = Colors.green);
    canvas.drawLine(
        Offset(aC.x, -aC.y),
        Offset(bC.x, -bC.y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 2);
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
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}

class _GrooveShape extends PaintShape {
  _GrooveShape({
    required this.color,
    required this.space,
    required this.a,
    required this.b,
  }) {
    constraint = space.addConstraint(constraint: lq.GrooveJoint(a: a, b: b, grooveA: mt.Vector2(-250, 100), grooveB: mt.Vector2(250, 100), anchorB: mt.Vector2.zero()));
  }
  final Color color;
  final lq.Space space;
  final lq.Body a;
  final lq.Body b;
  late lq.GrooveJoint constraint;

  var aC = mt.Vector2.zero();
  var bC = mt.Vector2.zero();

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    aC = constraint.a.transform.toTransformPoint((constraint).getGrooveA());
    bC = constraint.a.transform.toTransformPoint((constraint).getGrooveB());
    canvas.drawLine(
        Offset(aC.x, -aC.y),
        Offset(bC.x, -bC.y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = 2);
    canvas.restore();
  }
}

class _DollyShape extends PaintShape {
  _DollyShape({
    required this.color,
    required this.width,
    required this.height,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 10, moment: double.infinity))..setPosition(pos: pos);

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

class _HookShape extends PaintShape {
  _HookShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 1.0, moment: double.infinity))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setCollisionType(1)
      ..setSensor(true);
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
    body = space.addBody(body: lq.Body(mass: 30, moment: lq.Moment.forBox(30, width, height)))..setPosition(pos: pos);

    space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))
      ..setElasticity(0)
      ..setCollisionType(2);
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
