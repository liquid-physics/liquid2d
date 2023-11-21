import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:liquid_example/core/common.dart';
import 'package:liquid_example/core/fps_counter.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid_example/core/inputw.dart';
import 'package:liquid_example/core/paint_shape.dart';
import 'package:liquid_example/core/render_painter.dart';
import 'package:vector_math/vector_math_64.dart' as mt;

class PyramidTopple extends StatefulWidget {
  static const route = '/pyramid-topple';
  const PyramidTopple({super.key});

  @override
  State<PyramidTopple> createState() => _PyramidToppleState();
}

class _PyramidToppleState extends State<PyramidTopple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const PyramidToppleLayoutSize(),
    );
  }
}

class PyramidToppleLayoutSize extends StatelessWidget {
  const PyramidToppleLayoutSize({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PyramidToppleView(width: constraints.maxWidth, height: constraints.maxHeight),
    );
  }
}

class PyramidToppleView extends StatefulWidget {
  const PyramidToppleView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<PyramidToppleView> createState() => _PyramidToppleViewState();
}

class _PyramidToppleViewState extends State<PyramidToppleView> {
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
          PyramidToppleDraw(
            game: _game,
          ),
          FpsCounter(
            renderUpdate: _game.renderUpdate.stream,
          )
        ]));
  }
}

class PyramidToppleDraw extends StatefulWidget {
  const PyramidToppleDraw({super.key, required this.game});
  final Game game;
  @override
  State<PyramidToppleDraw> createState() => _PyramidToppleDrawState();
}

class _PyramidToppleDrawState extends State<PyramidToppleDraw> {
  var dominos = <_DominoShape>[];

  @override
  void initState() {
    super.initState();
    widget.game.space
      ..setIternation(iterations: 30)
      ..setGravity(gravity: mt.Vector2(0, -300))
      ..setSleepTimeThreshold(sleepTimeThreshold: 0.5)
      ..setCollisionSlop(collisionSlop: 0.5);

    widget.game.space.addShape(shape: lq.SegmentShape(body: widget.game.space.getStaticBody(), a: mt.Vector2(-600, -240), b: mt.Vector2(600, -240), radius: 0))
      ..setElasticity(1)
      ..setFriction(1)
      ..setFilter(notGrabbableFilter);

    int n = 12;
    double width = 4;
    double height = 30;
    for (var i = 0; i < n; i++) {
      for (var j = 0; j < (n - i); j++) {
        var offset = mt.Vector2((j - (n - 1 - i) * 0.5) * 1.5 * height, (i + 0.5) * (height + 2 * width) - width - 240);

        dominos.add(_DominoShape(space: widget.game.space, pos: offset, flipped: false));
        dominos.add(_DominoShape(space: widget.game.space, pos: offset + mt.Vector2(0, (width + height) / 2), flipped: true));

        if (j == 0) {
          dominos.add(_DominoShape(space: widget.game.space, pos: offset + mt.Vector2(.5 * (width - height), height + width), flipped: false));
        }

        if (j != n - i - 1) {
          dominos.add(_DominoShape(space: widget.game.space, pos: offset + mt.Vector2(height * .75, (height + 3 * width) / 2), flipped: true));
        } else {
          dominos.add(_DominoShape(space: widget.game.space, pos: offset + mt.Vector2(.5 * (height - width), height + width), flipped: false));
        }
      }
    }

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
                shapes: [...dominos],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _DominoShape extends PaintShape {
  _DominoShape({
    required this.space,
    required this.pos,
    required this.flipped,
  }) {
    body = space.addBody(body: lq.Body(mass: mass, moment: moment))..setPosition(pos: pos);
    space.addShape(shape: flipped ? lq.BoxShape(body: body, height: width, width: height, radius: 0) : lq.BoxShape(body: body, width: width - radius * 2, height: height, radius: radius))
      ..setElasticity(0)
      ..setFriction(.6);
  }
  final bool flipped;
  final lq.Space space;
  final mt.Vector2 pos;
  late lq.Body body;
  static double width = 4;
  static double height = 30;
  static double mass = 1;
  static double radius = .5;
  static double moment = lq.Moment.forBox(mass, width, height);

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    rotate(canvas: canvas, cx: body.getPosition().x, cy: -body.getPosition().y, angle: -body.getAngle());
    canvas.drawRect(Rect.fromCenter(center: Offset(body.getPosition().x, -body.getPosition().y), width: flipped ? height : width, height: flipped ? width - radius * 2 : height),
        Paint()..color = Colors.blueAccent);

    canvas.restore();
  }

  void rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }
}
