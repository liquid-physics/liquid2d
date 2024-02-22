import 'package:flutter/material.dart';
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:vector_math/vector_math_64.dart' as mt;

class OneWay extends StatefulWidget {
  const OneWay({super.key});
  static const route = '/oneway';

  @override
  State<OneWay> createState() => _OneWayState();
}

class _OneWayState extends State<OneWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const OneWayLayoutSize(),
    );
  }
}

class OneWayLayoutSize extends StatelessWidget {
  const OneWayLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OneWayView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class OneWayView extends StatefulWidget {
  const OneWayView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<OneWayView> createState() => _OneWayViewState();
}

class _OneWayViewState extends State<OneWayView> {
  late final Game _game;
  @override
  void dispose() {
    _game.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _game = Game(widget.width, widget.height);
    _game.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(children: [
          OneWayDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class OneWayDraw extends StatefulWidget {
  const OneWayDraw({super.key, required this.game});
  final Game game;
  @override
  State<OneWayDraw> createState() => _OneWayDrawState();
}

class _OneWayDrawState extends State<OneWayDraw> {
  late _SegmentShape segmentOneWay;
  late _CircleShape circle;
  @override
  void initState() {
    super.initState();
    late lq.Body staticBody;

    widget.game.space
      ..setIternation(iterations: 10)
      ..setGravity(gravity: mt.Vector2(0, -100));

    staticBody = widget.game.space.getStaticBody();
    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);
    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(widget.game.spaceMatrix.size.x / 2, widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);

    widget.game.space.addShape(
        shape: lq.SegmentShape(
            body: staticBody,
            a: mt.Vector2(-widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            b: mt.Vector2(widget.game.spaceMatrix.size.x / 2, -widget.game.spaceMatrix.size.y / 2),
            radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);

    segmentOneWay = _SegmentShape(color: Colors.blueAccent, space: widget.game.space);
    circle = _CircleShape(color: Colors.redAccent, radius: 15, space: widget.game.space, pos: mt.Vector2(0, -200));

    widget.game.space.addWildcardHandler(type: 1)
      ..preSolve((arbiter, space) {
        if (arbiter.getNormal().dot(mt.Vector2(0, 1)) < 0) return arbiter.ignore();
        return true;
      })
      ..postSolve((arbiter, space) {});

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
                shapes: [segmentOneWay, circle],
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
    required this.space,
  }) {
    space.addShape(shape: lq.SegmentShape(body: space.getStaticBody(), a: a, b: b, radius: 10))
      ..setElasticity(1)
      ..setFriction(1)
      ..setCollisionType(1)
      ..setFilter(notGrabbableFilter);
  }

  final Color color;
  final lq.Space space;
  var a = mt.Vector2(-160, -100);
  var b = mt.Vector2(160, -100);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 10 * 2
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
    body = space.addBody(body: lq.Body(mass: 10.0, moment: lq.Moment.forCircle(10.0, 0.0, radius, mt.Vector2.zero())))
      ..setPosition(pos: pos)
      ..setVelocity(vel: mt.Vector2(0, 170));

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(0)
      ..setFriction(.9)
      ..setCollisionType(2);
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
