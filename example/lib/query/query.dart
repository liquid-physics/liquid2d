import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:vector_math/vector_math_64.dart' as mt;

class Query extends StatefulWidget {
  const Query({super.key});
  static const route = '/query';
  @override
  State<Query> createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const QueryLayoutSize(),
    );
  }
}

class QueryLayoutSize extends StatelessWidget {
  const QueryLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => QueryView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class QueryView extends StatefulWidget {
  const QueryView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<QueryView> createState() => _QueryViewState();
}

class _QueryViewState extends State<QueryView> {
  late final Game _game;

  @override
  void initState() {
    super.initState();
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
          QueryDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class QueryDraw extends StatefulWidget {
  const QueryDraw({super.key, required this.game});
  final Game game;
  @override
  State<QueryDraw> createState() => _QueryDrawState();
}

class _QueryDrawState extends State<QueryDraw> {
  late _SegmentShape segment;
  late _StaticShape staticShape;
  late _PentagonShape pentagon;
  late _CircleShape cirlce;
  final lq.ShapeFilter sfa = lq.ShapeFilter(group: 0, categories: allCategories, mask: allCategories);

  @override
  void initState() {
    super.initState();
    widget.game.space.setIternation(iterations: 5);
    segment = _SegmentShape(color: Colors.greenAccent, space: widget.game.space);
    staticShape = _StaticShape(color: Colors.white, space: widget.game.space);
    pentagon = _PentagonShape(space: widget.game.space, color: Colors.blueAccent);
    cirlce = _CircleShape(color: Colors.orangeAccent, radius: 20, space: widget.game.space);

    widget.game.keyboardUpdate = (event) {};
    widget.game.physicUpdateAfter = (p0) {
      var (shape, info) = widget.game.space.segmentQueryFirst(start: start, end: end, radius: 10, filter: sfa);
      if (shape.isExist) {
        poi = info.point;
        nor = info.normal;
        alp = info.alpha;
        lineDraw1 = true;
        desc = 'Segment Query: Dist(${alp * (end - start).length}) Normal(${nor.x}, ${nor.y})';
      } else {
        lineDraw1 = false;
        alp = 1;
        desc = 'Segment Query (None)';
      }
    };

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  var start = mt.Vector2.zero();
  var end = mt.Vector2.zero();
  var lineDraw = true;
  var lineDraw1 = false;
  mt.Vector2 poi = mt.Vector2.zero();
  mt.Vector2 nor = mt.Vector2.zero();
  double alp = 0;
  var desc = '';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Query: Distance (${(end - start).length}) Point (${end.x} ${end.y}) $desc',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerHover: (details) {
              end = widget.game.spaceMatrix.mouseToView(Offset(details.localPosition.dx, details.localPosition.dy));
            },
            onPointerMove: (details) {
              end = widget.game.spaceMatrix.mouseToView(Offset(details.localPosition.dx, details.localPosition.dy));
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onSecondaryTapDown: (details) {
                start = widget.game.spaceMatrix.mouseToView(Offset(details.localPosition.dx, details.localPosition.dy));
                setState(() {
                  lineDraw = false;
                });
              },
              onSecondaryTapUp: (details) {
                setState(() {
                  lineDraw = true;
                });
              },
              child: InputW(
                game: widget.game,
                child: CustomPaint(
                  painter: RenderPainter(
                    game: widget.game,
                    shapes: [
                      _LineShape(color: Colors.yellow, a: start, b: mt.Vector2(_lerpDouble(start.x, end.x, alp), _lerpDouble(start.y, end.y, alp)), radius: 20),
                      if (lineDraw) ...[
                        _LineShape(color: Colors.greenAccent, a: start, b: end),
                      ],
                      if (lineDraw1) ...[
                        _LineShape(color: Colors.blue, a: mt.Vector2(_lerpDouble(start.x, end.x, alp), _lerpDouble(start.y, end.y, alp)), b: end),
                        _LineShape(color: Colors.red, a: poi, b: poi + (nor * 16)),
                      ],
                      segment,
                      staticShape,
                      pentagon,
                      cirlce,
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

double _lerpDouble(double a, double b, double t) {
  return a * (1.0 - t) + b * t;
}

class _SegmentShape extends PaintShape {
  _SegmentShape({
    required this.color,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: lq.Moment.forSegment(mass, a, b, 0)))..setPosition(pos: mt.Vector2(0, 100));
    space.addShape(shape: lq.SegmentShape(body: body, a: a, b: b, radius: 20));
  }

  final Color color;
  final lq.Space space;
  late lq.Body body;
  static const double mass = 1;
  static const double length = 100;
  var a = mt.Vector2(-length / 2, 0);
  var b = mt.Vector2(length / 2, 0);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawLine(
        Offset(a.x + body.getPosition().x, -a.y - body.getPosition().y),
        Offset(b.x + body.getPosition().x, -b.y - body.getPosition().y),
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20 * 2
          ..strokeJoin = StrokeJoin.miter);
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

class _StaticShape extends PaintShape {
  _StaticShape({
    required this.color,
    required this.space,
  }) {
    space.addShape(shape: lq.SegmentShape(body: space.getStaticBody(), a: a, b: b, radius: 0));
  }
  final Color color;
  final lq.Space space;
  var a = mt.Vector2(0, 300);
  var b = mt.Vector2(300, 0);
  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }
}

class _PentagonShape extends PaintShape {
  _PentagonShape({
    required this.space,
    required this.color,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: moment))..setPosition(pos: mt.Vector2(50, 30));

    space.addShape(shape: lq.PolyShape(body: body, vert: _pentagon, transform: Matrix4.identity(), radius: 10));
  }
  final lq.Space space;
  late lq.Body body;
  final Color color;

  static final _pentagon = <mt.Vector2>[
    for (int i = 0; i < 5; i++) mt.Vector2(30 * cos(-2.0 * pi * i / 5), 30 * sin(-2.0 * pi * i / 5)),
  ];
  static double mass = 1;
  static double moment = lq.Moment.forPoly(1, _pentagon, mt.Vector2.zero(), 0);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());

    canvas.drawPath(
        computePath([for (int i = 0; i < 5; i++) Offset(42 * cos(-2.0 * pi * i / 5) + body.getPosition().x, 42 * sin(-2.0 * pi * i / 5) + -body.getPosition().y)], 10),
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

  Path computePath(List<Offset> vertices, double radius) {
    final path = Path();
    final length = vertices.length;

    for (int i = 0; i <= length; i++) {
      final src = vertices[i % length];
      final dst = vertices[(i + 1) % length];

      final stepResult = _computeStep(src, dst, radius);
      final step = stepResult.point;
      final srcX = src.dx;
      final srcY = src.dy;
      final stepX = step.dx;
      final stepY = step.dy;

      if (i == 0) {
        path.moveTo(srcX + stepX, srcY + stepY);
      } else {
        path.quadraticBezierTo(srcX, srcY, srcX + stepX, srcY + stepY);
      }

      if (stepResult.drawSegment) {
        path.lineTo(dst.dx - stepX, dst.dy - stepY);
      }
    }

    return path;
  }

  _StepResult _computeStep(Offset a, Offset b, double radius) {
    Offset point = b - a;
    final dist = point.distance;
    if (dist <= radius * 2) {
      point *= 0.5;
      return _StepResult(false, point);
    } else {
      point *= radius / dist;
      return _StepResult(true, point);
    }
  }
}

class _StepResult {
  _StepResult(this.drawSegment, this.point);
  final bool drawSegment;
  final Offset point;
}

class _CircleShape extends PaintShape {
  _CircleShape({
    required this.color,
    required this.radius,
    required this.space,
  }) {
    body = space.addBody(body: lq.Body(mass: 1.0, moment: lq.Moment.forCircle(1.0, radius, 0, mt.Vector2.zero())))..setPosition(pos: mt.Vector2(100, 100));
    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()));
  }
  final double radius;
  final Color color;
  final lq.Space space;

  late lq.Body body;

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawCircle(Offset(body.getPosition().x, -body.getPosition().y), radius, Paint()..color = color);
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
