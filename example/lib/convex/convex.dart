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

class Convex extends StatefulWidget {
  const Convex({super.key});
  static const route = '/convex';

  @override
  State<Convex> createState() => _ConvexState();
}

class _ConvexState extends State<Convex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const ConvexLayoutSize(),
    );
  }
}

class ConvexLayoutSize extends StatelessWidget {
  const ConvexLayoutSize({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ConvexView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class ConvexView extends StatefulWidget {
  const ConvexView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<ConvexView> createState() => _ConvexViewState();
}

class _ConvexViewState extends State<ConvexView> {
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
          ConvexDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class ConvexDraw extends StatefulWidget {
  const ConvexDraw({super.key, required this.game});
  final Game game;
  @override
  State<ConvexDraw> createState() => _ConvexDrawState();
}

class _ConvexDrawState extends State<ConvexDraw> {
  var shp = <PaintShape>[];
  var isRightClick = false;
  var mouse = mt.Vector2.zero();
  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -500))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);

    var staticBody = widget.game.space.getStaticBody();
    shp = [
      _SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(-1000, -240), posB: mt.Vector2(1000, -240), staticBody: staticBody),
      _BoxShape(color: Colors.purple, width: 50, height: 70, space: widget.game.space)
    ];

    widget.game.physicUpdateBefore = (dt) {
      var tolerance = 2.0;
      var shape = (shp[1] as _BoxShape).shape as lq.PolyShape;
      if (isRightClick && shape.pointQuery(point: mouse).$1 > tolerance) {
        var body = shape.getBody();
        var count = shape.getCount();
        var verts = <mt.Vector2>[];
        for (var i = 0; i < count; i++) {
          verts.add(shape.getVert(i));
        }

        verts.add(body.worldToLocal(mouse));
        var hullC = lq.quickHull(verts, tolerance);
        var centroid = lq.Centeroid.forPoly(hullC.$2);

        var neg = mt.Vector2(-centroid.x, -centroid.y);

        // Recalculate the body properties to match the updated shape.
        var mass = lq.Area.forPoly(verts, 0) * 1 / 10000;
        body.setMass(mass);
        body.setMoment(lq.Moment.forPoly(mass, verts, neg, 0));
        body.setPosition(pos: body.localToWorld(centroid));

        // Use the setter function from chipmunk_unsafe.h.
        // You could also remove and recreate the shape if you wanted.
        widget.game.space.removeShape(shape: shape);
        (shp[1] as _BoxShape).poly = verts;
        (shp[1] as _BoxShape).centroid = centroid;
        (shp[1] as _BoxShape).shape = widget.game.space.addShape(
            shape: lq.PolyShape(
                body: body,
                vert: verts,
                transform: Matrix4.identity()
                  ..translate(neg.x, neg.y)
                  ..transposed(),
                radius: 0))
          ..setFriction(.6);
      }
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
            onPointerMove: (event) {
              if (isRightClick) {
                mouse = widget.game.spaceMatrix.mouseToView(Offset(event.localPosition.dx, event.localPosition.dy));
              }
            },
            onPointerUp: (event) {
              if (isRightClick) {
                isRightClick = false;
              }
            },
            child: InputW(
              onSecondaryTapDown: (event) {
                mouse = widget.game.spaceMatrix.mouseToView(Offset(event.localPosition.dx, event.localPosition.dy));
                isRightClick = true;
              },
              game: widget.game,
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: [...shp],
                ),
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

class _BoxShape extends PaintShape {
  _BoxShape({required this.color, required this.width, required this.height, required this.space}) {
    body = space.addBody(body: lq.Body(mass: width * height * 1 / 10000, moment: lq.Moment.forBox(width * height * 1 / 10000, width, height)));
    poly = [mt.Vector2(-width / 2, height / 2), mt.Vector2(width / 2, height / 2), mt.Vector2(width / 2, -height / 2), mt.Vector2(-width / 2, -height / 2)];
    shape = space.addShape(shape: lq.PolyShape(body: body, vert: poly, transform: Matrix4.identity(), radius: 0))..setFriction(.6);
  }

  final double width;
  final double height;
  final Color color;
  final lq.Space space;
  late List<mt.Vector2> poly;
  late lq.Shape shape;
  late lq.Body body;
  var centroid = mt.Vector2.zero();

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in poly) Offset(ele.x + body.getPosition().x - centroid.x, -ele.y - body.getPosition().y + centroid.y)]),
        BlendMode.dst,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color);

    canvas.restore();
    canvas.save();
    canvas.drawCircle(Offset(body.getPosition().x, -body.getPosition().y), 3, Paint()..color = Colors.blue);
    canvas.drawCircle(Offset(body.getPosition().x + body.getCenterOfGravity().x, -body.getPosition().y - body.getCenterOfGravity().y), 3, Paint()..color = Colors.orange);

    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
