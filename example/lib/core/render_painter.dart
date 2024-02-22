import 'package:flutter/material.dart';
import 'package:liquid2d_example/core/game.dart';
import 'package:liquid2d_example/core/paint_shape.dart';

class RenderPainter extends CustomPainter {
  final List<PaintShape> shapes;
  final Game game;
  RenderPainter({required this.game, required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.transform(game.spaceMatrix.viewMatrix.storage);
    game.drawDebugPaint(canvas, size);
    for (var i = 0; i < shapes.length; i++) {
      shapes[i].draw(canvas, size);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RenderPainter oldDelegate) => true;
}
