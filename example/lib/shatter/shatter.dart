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

class Shatter extends StatefulWidget {
  const Shatter({super.key});
  static const route = '/shatter';
  @override
  State<Shatter> createState() => ShatterState();
}

class ShatterState extends State<Shatter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const ShatterLayoutSize(),
    );
  }
}

class ShatterLayoutSize extends StatelessWidget {
  const ShatterLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ShatterView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class ShatterView extends StatefulWidget {
  const ShatterView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<ShatterView> createState() => ShatterViewState();
}

class ShatterViewState extends State<ShatterView> {
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
          ShatterDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

var _max_vertexes_per_voronoi = 16;

class ShatterDraw extends StatefulWidget {
  const ShatterDraw({super.key, required this.game});
  final Game game;

  @override
  State<ShatterDraw> createState() => _ShatterDrawState();
}

class _ShatterDrawState extends State<ShatterDraw> {
  final _random = Random();
  var shp = <PaintShape>[];
  var shatshap = <_PrimitiveShape>[];
  @override
  void initState() {
    super.initState();

    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -500))
      ..setSleepTimeThreshold(sleepTimeThreshold: .5)
      ..setCollisionSlop(collisionSlop: .5);
    var staticBody = widget.game.space.getStaticBody();
    shp.add(_SegmentShape(color: Colors.white, radius: 1, space: widget.game.space, posA: mt.Vector2(-1000, -240), posB: mt.Vector2(1000, -240), staticBody: staticBody));
    shatshap.add(_BoxShape(color: Colors.purple, width: 200, height: 200, space: widget.game.space, pos: mt.Vector2.zero()));
    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  void shatterShape(lq.Shape shape, double cellSize, mt.Vector2 focus) {
    var bb = shape.getRect();
    int width = (((bb.right - bb.left) / cellSize) + 1).toInt();
    int height = (((bb.top - bb.bottom) / cellSize) + 1).toInt();
    var context = (_random.nextInt(4294967296), cellSize, width, height, bb, focus);

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        var cell = worleyPoint(i, j, context);
        var (double val, _) = shape.pointQuery(point: cell);
        if (val < 0.0) {
          shatterCell(shape, cell, i, j, context);
        }
      }
    }

    removeRenderShape(shape);
    var body = shape.getBody();
    widget.game.space.removeShape(shape: shape);
    widget.game.space.removeBody(body: body);
    shape.destroy();
    body.destroy();
  }

  void shatterCell(lq.Shape shape, mt.Vector2 cell, int cellI, int cellJ, (int, double, int, int, Rect, mt.Vector2) context) {
    var (int _, double _, int width, int height, Rect _, mt.Vector2 _) = context;

    var body = shape.getBody();

    var ping = <mt.Vector2>[];
    var pong = <mt.Vector2>[];

    int count = (shape as lq.PolyShape).getCount();
    count = (count > _max_vertexes_per_voronoi ? _max_vertexes_per_voronoi : count);

    for (int i = 0; i < count; i++) {
      ping.add(body.localToWorld(shape.getVert(i)));
    }

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        var (double val, _) = shape.pointQuery(point: cell);

        if (!(i == cellI && j == cellJ) && val < 0.0) {
          pong = clipCell(shape, cell, i, j, context, ping, count);
          count = pong.length;
          ping = [...pong];
        }
      }
    }

    // CREATE DRAW CREATE DRAW CREATE DRAW
    shatshap.add(_ClipShape(space: widget.game.space, orishape: shape, color: Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), clipped: ping));
  }

  List<mt.Vector2> clipCell(lq.Shape shape, mt.Vector2 center, int i, int j, (int, double, int, int, Rect, mt.Vector2) context, List<mt.Vector2> verts, int count) {
    var other = worleyPoint(i, j, context);
    var (double val, _) = shape.pointQuery(point: other);

    if (val > 0.0) {
      return verts;
    }

    var n = other - center;
    var dist = n.dot(cpvlerp(center, other, 0.5));
    var clipped = <mt.Vector2>[];

    for (int j = 0, i = count - 1; j < count; i = j, j++) {
      var a = verts[i];
      var a_dist = a.dot(n) - dist;

      if (a_dist <= 0.0) {
        clipped.add(a);
      }

      var b = verts[j];
      var b_dist = b.dot(n) - dist;

      if (a_dist * b_dist < 0.0) {
        var t = (a_dist).abs() / ((a_dist).abs() + (b_dist).abs());

        clipped.add(cpvlerp(a, b, t));
      }
    }

    return clipped;
  }

  mt.Vector2 cpvlerp(mt.Vector2 v1, mt.Vector2 v2, double t) {
    return (v1 * (1.0 - t)) + v2 * t;
  }

  mt.Vector2 worleyPoint(int i, int j, (int, double, int, int, Rect, mt.Vector2) context) {
    var (int rand, double size, int width, int height, Rect bb, mt.Vector2 _) = context;

    var fv = hashVect(i, j, rand);

    return mt.Vector2(
      cpflerp(bb.left, bb.right, .5) + size * (i + fv.x - width * 0.5),
      cpflerp(bb.bottom, bb.top, 0.5) + size * (j + fv.y - height * 0.5),
    );
  }

  mt.Vector2 hashVect(int x, int y, int seed) {
    var border = 0.05;
    int h = (x * 1640531513 ^ y * 2654435789) + seed;

    return mt.Vector2(
      cpflerp(border, 1.0 - border, ((h & 0xFFFF).toDouble() / 0xFFFF.toDouble())),
      cpflerp(border, 1.0 - border, (((h >> 16) & 0xFFFF).toDouble() / 0xFFFF.toDouble())),
    );
  }

  void removeRenderShape(lq.Shape shape) {
    shatshap.removeWhere((it) {
      return it.shape == shape;
    });
  }

  double cpflerp(double f1, double f2, double t) {
    return f1 * (1.0 - t) + f2 * t;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InputW(
            onSecondaryTapDown: (details) {
              var (lq.Shape sh, lq.PointQueryInfo info) = widget.game.space.pointQueryNearest(mouse: widget.game.spaceMatrix.mouseToView(details.localPosition), radius: 0, filter: grabFilter);
              if (sh.isExist) {
                var boundingBox = info.shape.getRect();
                var cellSize = max(boundingBox.right - boundingBox.left, boundingBox.top - boundingBox.bottom) / 5;
                if (cellSize > 5) {
                  shatterShape(info.shape, cellSize, widget.game.spaceMatrix.mouseToView(details.localPosition));
                }
              }
            },
            game: widget.game,
            child: CustomPaint(
              painter: RenderPainter(
                game: widget.game,
                shapes: [...shp, ...shatshap],
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
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: width * height * 1 / 10000, moment: lq.Moment.forBox(width * height * 1 / 10000, width, height)))..setPosition(pos: pos);

    shape = space.addShape(shape: lq.BoxShape(body: body, width: width, height: height, radius: 0.0))..setFriction(.6);
  }

  final double width;
  final double height;
  final Color color;
  final lq.Space space;
  final mt.Vector2 pos;

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

class _ClipShape extends _PrimitiveShape {
  _ClipShape({
    required this.space,
    required this.orishape,
    required this.color,
    required this.clipped,
  }) {
    oriBody = orishape.getBody();

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
  final Color color;
  late lq.Body oriBody;
  final List<mt.Vector2> clipped;

  late mt.Vector2 centroid;
  late double mass;
  late double moment;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
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

abstract class _PrimitiveShape extends PaintShape {
  late final lq.Body body;
  late final lq.Shape shape;
}
