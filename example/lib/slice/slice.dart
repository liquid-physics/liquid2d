// ignore_for_file: unused_element, non_constant_identifier_names

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

class Slice extends StatefulWidget {
  const Slice({super.key});
  static const route = '/slice';

  @override
  State<Slice> createState() => _SliceState();
}

class _SliceState extends State<Slice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const SliceLayoutSize(),
    );
  }
}

class SliceLayoutSize extends StatelessWidget {
  const SliceLayoutSize({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SliceView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class SliceView extends StatefulWidget {
  const SliceView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<SliceView> createState() => _SliceViewState();
}

class _SliceViewState extends State<SliceView> {
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
          SliceDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class SliceDraw extends StatefulWidget {
  const SliceDraw({super.key, required this.game});
  final Game game;

  @override
  State<SliceDraw> createState() => _SliceDrawState();
}

class _SliceDrawState extends State<SliceDraw> {
  late _SegmentShape line;
  var end = mt.Vector2.zero();
  var start = mt.Vector2.zero();
  var isSlicing = false;
  var clipShapes = <_PrimitiveShape>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -500))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);

    var staticBody = widget.game.space.getStaticBody();
    line = _SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(-1000, -240), posB: mt.Vector2(1000, -240), staticBody: staticBody);
    clipShapes.add(_BoxShape(color: Colors.purpleAccent, width: 200, height: 300, space: widget.game.space));

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  void slice(lq.Shape shape, mt.Vector2 point, mt.Vector2 normal, double alpha) {
    // Check that the slice was complete by checking that the endpoints aren't in the sliced shape.
    var (distA, _) = shape.pointQuery(point: start);
    var (distB, _) = shape.pointQuery(point: end);
    if (distA > 0.0 && distB > 0.0) {
      // Can't modify the space during a query.
      // Must make a post-step callback to do the actual slicing.
      widget.game.space.addPostStepCallback<lq.Shape>(shape, slicePost);
    }
  }

  void slicePost(lq.Space space, lq.Shape shape) {
    // Clipping plane normal and distance.
    var subs = end - start;
    var n = mt.Vector2(-subs.y, subs.x)..normalize();
    var dist = start.dot(n);

    clipShapes.add(_ClipShape(space: space, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), orishape: shape as lq.PolyShape, normal: n, distance: dist));
    clipShapes.add(_ClipShape(space: space, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), orishape: shape, normal: n..negate(), distance: -dist));

    var body = shape.getBody();
    removeRenderShape(shape);
    space.removeShape(shape: shape);
    space.removeBody(body: body);
    shape.destroy();
    body.destroy();
  }

  void removeRenderShape(lq.Shape shape) {
    clipShapes.removeWhere((it) {
      return it.shape == shape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerMove: (details) {
              if (isSlicing) end = widget.game.spaceMatrix.mouseToView(Offset(details.localPosition.dx, details.localPosition.dy));
            },
            onPointerUp: (details) {
              if (isSlicing) {
                widget.game.space.segmentQuery(
                  start: start,
                  end: end,
                  radius: 0,
                  filter: grabFilter,
                  queryFunc: slice,
                );

                isSlicing = false;
              }
            },
            child: InputW(
              onSecondaryTapDown: (details) {
                start = end = widget.game.spaceMatrix.mouseToView(Offset(details.localPosition.dx, details.localPosition.dy));
                isSlicing = true;
              },
              game: widget.game,
              child: CustomPaint(
                painter: RenderPainter(
                  game: widget.game,
                  shapes: [line, ...clipShapes, if (isSlicing) _LineShape(color: Colors.green, a: start, b: end)],
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

class _BoxShape extends _PrimitiveShape {
  _BoxShape({
    required this.color,
    required this.width,
    required this.height,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: 1 / 10000 * width * height, moment: lq.Moment.forBox(1 / 10000 * width * height, width, height)));

    shape = space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))..setFriction(.6);
  }

  final double width;
  final double height;
  final Color color;
  final lq.Space space;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawRect(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: width, height: height), Paint()..color = color);
    canvas.restore();
    canvas.save();
    canvas.drawCircle(Offset(body.getPosition().x + body.getCenterOfGravity().x, -body.getPosition().y - body.getCenterOfGravity().y), 3, Paint()..color = Colors.orange);

    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

class _LineShape extends PaintShape {
  _LineShape({required this.color, required this.a, required this.b, this.radius = 2});

  final Color color;
  final mt.Vector2 a;
  final mt.Vector2 b;
  final double radius;
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = radius
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}

class _ClipShape extends _PrimitiveShape {
  _ClipShape({
    required this.space,
    required this.orishape,
    required this.normal,
    required this.distance,
    required this.color,
  }) {
    oriBody = orishape.getBody();

    int count = orishape.getCount();
    clipped = <mt.Vector2>[];

    for (int i = 0, j = count - 1; i < count; j = i, i++) {
      var a = oriBody.localToWorld(orishape.getVert(j));
      var a_dist = a.dot(normal) - distance;

      if (a_dist < 0.0) {
        clipped.add(a);
      }

      var b = oriBody.localToWorld(orishape.getVert(i));
      var b_dist = b.dot(normal) - distance;

      if (a_dist * b_dist < 0.0) {
        var t = a_dist.abs() / (a_dist.abs() + b_dist.abs());
        clipped.add(cpvlerp(a, b, t));
      }
    }
    centroid = lq.Centeroid.forPoly(clipped);
    mass = lq.Area.forPoly(clipped, 0) * (1.0 / 10000.0);
    var neg = mt.Vector2(-centroid.x, -centroid.y);
    moment = lq.Moment.forPoly(mass, clipped, neg, 0);

    body = space.addBody(body: lq.Body(mass: mass, moment: moment))
      ..setPosition(pos: centroid)
      ..setVelocity(vel: oriBody.getVelocityAtWorldPoint(point: centroid))
      ..setAngularVelocity(oriBody.getAngularVelocity());

    shape = space.addShape(
        shape: lq.PolyShape(
            body: body,
            vert: clipped,
            transform: Matrix4.identity()
              ..translate(neg.x, neg.y)
              ..transposed(),
            radius: 0))
      ..setFriction(orishape.getFriction());
  }
  final lq.Space space;
  final lq.PolyShape orishape;
  final mt.Vector2 normal;
  final Color color;
  final double distance;
  late lq.Body oriBody;
  late List<mt.Vector2> clipped;

  late mt.Vector2 centroid;
  late double mass;
  late double moment;

  late mt.Matrix4 cenNeg;

  mt.Vector2 cpvlerp(mt.Vector2 v1, mt.Vector2 v2, double t) {
    return (v1 * (1.0 - t)) + v2 * t;
  }

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();

    //print('$centroid ${body.getPosition()}');
    //canvas.transform(cenNeg.storage);

    for (var element in clipped) {
      var text = TextSpan(text: '(${element.x.toStringAsFixed(2)}, ${element.y.toStringAsFixed(2)})', style: const TextStyle(color: Colors.white));
      var painter = TextPainter(text: text, textDirection: TextDirection.ltr);
      painter.layout();
      painter.paint(canvas, Offset(element.x, -element.y));
      canvas.drawCircle(Offset(element.x, -element.y), 3, Paint()..color = Colors.white);
    }

    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [for (var ele in clipped) Offset(ele.x + body.getPosition().x - centroid.x, -ele.y - body.getPosition().y + centroid.y)]),
        BlendMode.dst,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color);
    //canvas.drawCircle(Offset(newBody.getPosition().x + (centroid..negate()).x, -newBody.getPosition().y - (centroid..negate()).y), 5, Paint()..color = Colors.red);
    canvas.restore();
    canvas.save();
    //canvas.drawCircle(Offset(body.getPosition().x + centroid.x, -body.getPosition().y - centroid.y), 3, Paint()..color = Colors.green);
    canvas.drawCircle(Offset(body.getPosition().x, -body.getPosition().y), 3, Paint()..color = Colors.blue);
    //canvas.drawCircle(Offset(centroid.x, centroid.y), 3, Paint()..color = Colors.yellow);
    canvas.drawCircle(Offset(body.getPosition().x + body.getCenterOfGravity().x, -body.getPosition().y - body.getCenterOfGravity().y), 3, Paint()..color = Colors.orange);

    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}

abstract class _PrimitiveShape extends PaintShape {
  late final lq.Body body;
  late final lq.Shape shape;
}
