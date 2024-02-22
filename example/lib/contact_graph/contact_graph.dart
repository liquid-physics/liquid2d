import 'package:flutter/material.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:liquid2d_example/core/common.dart';
import 'package:liquid2d_example/core/fps_counter.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/inputw.dart';
import 'package:liquid2d_example/core/paint_shape.dart';
import 'package:liquid2d_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class ContactGraph extends StatefulWidget {
  const ContactGraph({super.key});
  static const route = '/contact-graph';

  @override
  State<ContactGraph> createState() => _ContactGraphState();
}

class _ContactGraphState extends State<ContactGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const ContactGraphLayoutSize(),
    );
  }
}

class ContactGraphLayoutSize extends StatelessWidget {
  const ContactGraphLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ContactGraphView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class ContactGraphView extends StatefulWidget {
  const ContactGraphView({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<ContactGraphView> createState() => _ContactGraphViewState();
}

class _ContactGraphViewState extends State<ContactGraphView> {
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
          ContactGraphDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class ContactGraphDraw extends StatefulWidget {
  const ContactGraphDraw({super.key, required this.game});
  final Game game;

  @override
  State<ContactGraphDraw> createState() => _ContactGraphDrawState();
}

class _ContactGraphDrawState extends State<ContactGraphDraw> {
  var segmentLine = <_SegmentShape>[];
  var box = <_BoxShape>[];
  late _CircleShape circle;
  late lq.Body scaleBody;
  var textDesc = '';
  var textDesc1 = '';
  var textDesc2 = '';
  var impulseSum = mt.Vector2.zero();
  var count = 0;
  var magnitudoSum = 0.0;
  var vectorSum = mt.Vector2.zero();
  @override
  void initState() {
    super.initState();

    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -300))
      ..setCollisionSlop(collisionSlop: .5)
      ..setSleepTimeThreshold(sleepTimeThreshold: 1);

    var staticBody = widget.game.space.getStaticBody();
    scaleBody = widget.game.space.addBody(body: lq.StaticBody());
    segmentLine = [
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(-320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(320, -240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, -240), posB: mt.Vector2(320, -240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 2, space: widget.game.space, posA: mt.Vector2(-320, 240), posB: mt.Vector2(320, 240), staticBody: staticBody),
      _SegmentShape(color: Colors.white, radius: 4, space: widget.game.space, posA: mt.Vector2(-240, -180), posB: mt.Vector2(-140, -180), staticBody: scaleBody),
    ];

    box = [for (var i = 0; i < 5; i++) _BoxShape(color: Colors.orangeAccent, width: 30, height: 30, space: widget.game.space, pos: mt.Vector2(0, i * 32 - 220))];
    circle = _CircleShape(color: Colors.redAccent, radius: 15, space: widget.game.space, pos: mt.Vector2(120, -240 + 15 + 5));

    widget.game.physicUpdateAfter = (p0) {
      impulseSum = mt.Vector2.zero();
      scaleBody.eachArbiter(scale);

      var force = impulseSum.length / p0;
      var g = widget.game.space.getGravity();
      var weight = g.dot(impulseSum) / (g.length2 * p0);
      textDesc = 'Total force: ${force.toStringAsFixed(2)}, Total weight: ${weight.toStringAsFixed(2)}. ';

      count = 0;
      circle.body.eachArbiter(ball);
      textDesc1 = 'The ball is touching $count shapes.\n';

      magnitudoSum = 0.0;
      vectorSum = mt.Vector2.zero();
      circle.body.eachArbiter(estimate);

      double crushForce = (magnitudoSum - vectorSum.length) * p0;
      if (crushForce > 10.0) {
        textDesc2 = "The ball is being crushed. (f: ${crushForce.toStringAsFixed(2)})";
      } else {
        textDesc2 = "The ball is not being crushed. (f: ${crushForce.toStringAsFixed(2)})";
      }
    };

    widget.game.renderUpdate.stream.listen((event) {
      setState(() {});
    });
  }

  void scale(lq.Body body, lq.Arbiter arbiter) {
    impulseSum += arbiter.totalImpulse();
  }

  void ball(lq.Body body, lq.Arbiter arbiter) {
    count++;
  }

  void estimate(lq.Body body, lq.Arbiter arbiter) {
    var j = arbiter.totalImpulse();
    magnitudoSum += j.length;
    vectorSum = vectorSum + j;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Place objects on the scale to weigh them. The ball marks the shapes it\'s sitting on.\n$textDesc$textDesc1$textDesc2',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned.fill(
          child: InputW(
            game: widget.game,
            child: CustomPaint(
              painter: RenderPainter(
                game: widget.game,
                shapes: [...segmentLine, ...box, circle],
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
  }) {
    body = space.addBody(body: lq.Body(mass: 1, moment: lq.Moment.forBox(1, width, height)))..setPosition(pos: pos);

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

class _CircleShape extends PaintShape {
  _CircleShape({
    required this.color,
    required this.radius,
    required this.space,
    required this.pos,
  }) {
    body = space.addBody(body: lq.Body(mass: 10.0, moment: lq.Moment.forCircle(10.0, 0.0, radius, mt.Vector2.zero())))..setPosition(pos: pos);

    space.addShape(shape: lq.CircleShape(body: body, radius: radius, offset: mt.Vector2.zero()))
      ..setElasticity(0)
      ..setFriction(.9);
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
