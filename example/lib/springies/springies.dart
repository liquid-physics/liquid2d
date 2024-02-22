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

class Springies extends StatefulWidget {
  const Springies({super.key});
  static const route = '/springies';

  @override
  State<Springies> createState() => _SpringiesState();
}

class _SpringiesState extends State<Springies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const SpringiesLayoutSize(),
    );
  }
}

class SpringiesLayoutSize extends StatelessWidget {
  const SpringiesLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SpringiesView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class SpringiesView extends StatefulWidget {
  const SpringiesView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<SpringiesView> createState() => _SpringiesViewState();
}

class _SpringiesViewState extends State<SpringiesView> {
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
          SpringiesDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class SpringiesDraw extends StatefulWidget {
  const SpringiesDraw({super.key, required this.game});
  final Game game;
  @override
  State<SpringiesDraw> createState() => _SpringiesDrawState();
}

class _SpringiesDrawState extends State<SpringiesDraw> {
  var bar = <_BarShape>[];
  var spring = <_SpringShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    var sh1 = _BarShape(space: widget.game.space, a: mt.Vector2(-240, 160), b: mt.Vector2(-160, 80), group: 1, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh2 = _BarShape(space: widget.game.space, a: mt.Vector2(-160, 80), b: mt.Vector2(-80, 160), group: 1, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh3 = _BarShape(space: widget.game.space, a: mt.Vector2(0, 160), b: mt.Vector2(80, 0), group: 0, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh4 = _BarShape(space: widget.game.space, a: mt.Vector2(160, 160), b: mt.Vector2(240, 160), group: 0, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh5 = _BarShape(space: widget.game.space, a: mt.Vector2(-240, 0), b: mt.Vector2(-160, -80), group: 2, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh6 = _BarShape(space: widget.game.space, a: mt.Vector2(-160, -80), b: mt.Vector2(-80, 0), group: 2, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh7 = _BarShape(space: widget.game.space, a: mt.Vector2(-80, 0), b: mt.Vector2(0, 0), group: 2, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh8 = _BarShape(space: widget.game.space, a: mt.Vector2(0, -80), b: mt.Vector2(80, -80), group: 0, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh9 = _BarShape(space: widget.game.space, a: mt.Vector2(240, 80), b: mt.Vector2(160, 0), group: 3, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh10 = _BarShape(space: widget.game.space, a: mt.Vector2(160, 0), b: mt.Vector2(240, -80), group: 3, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh11 = _BarShape(space: widget.game.space, a: mt.Vector2(-240, -80), b: mt.Vector2(-160, -160), group: 4, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh12 = _BarShape(space: widget.game.space, a: mt.Vector2(-160, -160), b: mt.Vector2(-80, -160), group: 4, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh13 = _BarShape(space: widget.game.space, a: mt.Vector2(0, -160), b: mt.Vector2(80, -160), group: 0, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    var sh14 = _BarShape(space: widget.game.space, a: mt.Vector2(160, -160), b: mt.Vector2(240, -160), group: 0, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));

    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: sh1.bo, b: sh2.bo, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, -40)));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: sh5.bo, b: sh6.bo, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, -40)));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: sh6.bo, b: sh7.bo, anchorA: mt.Vector2(40, 40), anchorB: mt.Vector2(-40, 0)));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: sh9.bo, b: sh10.bo, anchorA: mt.Vector2(-40, -40), anchorB: mt.Vector2(-40, 40)));
    widget.game.space.addConstraint(constraint: lq.PivotJoint(a: sh11.bo, b: sh12.bo, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, 0)));
    bar = [
      sh1, sh2, sh3, sh4, sh5, sh6, sh7, sh8, sh9, sh10, sh11, sh12, sh13,
      sh14 //
    ];
    lq.Body staticBody = widget.game.space.getStaticBody();

    spring = [
      _SpringShape(space: widget.game.space, a: staticBody, b: sh1.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-320, 240), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh1.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-320, 80), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh1.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-160, 240), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh2.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-160, 240), anchorB: mt.Vector2(40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh2.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(0, 240), anchorB: mt.Vector2(40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh3.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(80, 240), anchorB: mt.Vector2(-40, 80)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh4.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(80, 240), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh4.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(320, 240), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh5.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-320, 80), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh9.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(320, 80), anchorB: mt.Vector2(40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh10.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(320, 0), anchorB: mt.Vector2(40, -40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh10.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(320, -160), anchorB: mt.Vector2(40, -40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh11.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-320, -160), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh12.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-240, -240), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh12.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(0, -240), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh13.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(0, -240), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh13.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(80, -240), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(80, -240), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(240, -240), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: staticBody, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(320, -160), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: sh1.bo, b: sh5.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: sh1.bo, b: sh6.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(40, 40)), //
      _SpringShape(space: widget.game.space, a: sh2.bo, b: sh3.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, 40), anchorB: mt.Vector2(-40, 80)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh4.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-40, 80), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh4.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -80), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh7.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -80), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh7.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-40, 80), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh8.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -80), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: sh3.bo, b: sh9.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -80), anchorB: mt.Vector2(-40, -40)), //
      _SpringShape(space: widget.game.space, a: sh4.bo, b: sh9.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, 0), anchorB: mt.Vector2(40, 40)), //
      _SpringShape(space: widget.game.space, a: sh5.bo, b: sh11.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-40, 40), anchorB: mt.Vector2(-40, 40)), //
      _SpringShape(space: widget.game.space, a: sh5.bo, b: sh11.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(40, -40)), //
      _SpringShape(space: widget.game.space, a: sh7.bo, b: sh8.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, 0), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh8.bo, b: sh12.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-40, 0), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: sh8.bo, b: sh13.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(-40, 0), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh8.bo, b: sh13.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, 0), anchorB: mt.Vector2(40, 0)), //
      _SpringShape(space: widget.game.space, a: sh8.bo, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, 0), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh10.bo, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, 0)), //
      _SpringShape(space: widget.game.space, a: sh10.bo, b: sh14.bo, restLength: 0, stiff: 100, damp: .5, anchorA: mt.Vector2(40, -40), anchorB: mt.Vector2(-40, 0)), //
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
                shapes: [...bar, ...spring],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _BarShape extends PaintShape {
  final lq.Space space;
  final mt.Vector2 a;
  final mt.Vector2 b;
  late mt.Vector2 center;
  final int group;
  final Color color;

  late lq.Body body;
  static const int allCategories = ~0;

  _BarShape({required this.space, required this.a, required this.b, required this.group, required this.color}) {
    center = (a + b) * 1 / 2;
    var length = (b - a).length;
    var mass = length / 160;
    body = space.addBody(body: lq.Body(mass: mass, moment: mass * length * length / 12))..setPosition(pos: center);

    space.addShape(shape: lq.SegmentShape(body: body, a: a - center, b: b - center, radius: 10)).setFilter(lq.ShapeFilter(group: group, categories: allCategories, mask: allCategories));
  }

  lq.Body get bo => body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawLine(
        Offset((a - center).x + body.getPosition().x, -(a - center).y - body.getPosition().y),
        Offset((b - center).x + body.getPosition().x, -(b - center).y - body.getPosition().y),
        Paint()
          ..color = color
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20);
    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _SpringShape extends PaintShape {
  final lq.Space space;
  final lq.Body a;
  final lq.Body b;
  final mt.Vector2 anchorA;
  final mt.Vector2 anchorB;
  final double restLength;
  final double stiff;
  final double damp;
  late lq.Constraint constraint;
  _SpringShape({required this.space, required this.a, required this.b, required this.restLength, required this.stiff, required this.damp, required this.anchorA, required this.anchorB}) {
    constraint = lq.DampedSpring(a: a, b: b, anchorA: anchorA, anchorB: anchorB, restLength: restLength, stiffness: stiff, damping: damp)
      ..setSpringForceFunc((constraint, dist) {
        var clamp = 20.0;
        var dk = clampDouble(constraint.getRestLength() - dist, -clamp, clamp) * constraint.getStiffness();
        return dk;
      });

    space.addConstraint(constraint: constraint);
  }

  late mt.Vector2 aC;
  late mt.Vector2 bC;

  static List<mt.Vector2> springVerts = [
    mt.Vector2(0.00, 0.0),
    mt.Vector2(0.20, 0.0),
    mt.Vector2(0.25, 3.0),
    mt.Vector2(0.30, -6.0),
    mt.Vector2(0.35, 6.0),
    mt.Vector2(0.40, -6.0),
    mt.Vector2(0.45, 6.0),
    mt.Vector2(0.50, -6.0),
    mt.Vector2(0.55, 6.0),
    mt.Vector2(0.60, -6.0),
    mt.Vector2(0.65, 6.0),
    mt.Vector2(0.70, -3.0),
    mt.Vector2(0.75, 6.0),
    mt.Vector2(0.80, 0.0),
    mt.Vector2(1.00, 0.0),
  ];

  List<mt.Vector2> points = List.filled(springVerts.length, mt.Vector2.zero());
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    aC = constraint.a.transform.toTransformPoint((constraint as lq.DampedSpring).getAnchorA());
    bC = constraint.b.transform.toTransformPoint((constraint as lq.DampedSpring).getAnchorB());
    canvas.drawCircle(Offset(aC.x, -aC.y), 5, Paint()..color = Colors.green);
    canvas.drawCircle(Offset(bC.x, -bC.y), 5, Paint()..color = Colors.green);

    var delta = bC - aC;
    var cos = delta.x;
    var sin = delta.y;
    var s = 1.0 / delta.length;

    var r1 = mt.Vector2(cos, -sin * s);
    var r2 = mt.Vector2(sin, cos * s);

    for (int i = 0; i < springVerts.length; i++) {
      mt.Vector2 v = springVerts[i];
      points[i] = mt.Vector2(mt.dot2(v, r1) + aC.x, mt.dot2(v, r2) + aC.y);
    }

    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
          Offset(points[i].x, -points[i].y),
          Offset(points[i + 1].x, -points[i + 1].y),
          Paint()
            ..color = Colors.redAccent
            ..strokeJoin = StrokeJoin.round
            ..strokeWidth = 2);
    }

    canvas.restore();
  }
}
