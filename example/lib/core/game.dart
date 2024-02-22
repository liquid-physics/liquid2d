// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:liquid2d_example/core/input_event.dart';
import 'package:liquid2d_example/core/space_matrix.dart';
import 'package:liquid2d/liquid2d.dart' as lq;
import 'package:vector_math/vector_math_64.dart' as mt;

const int grabbableMaskBit = 1 << 31;
const int allCategories = ~0;
final lq.ShapeFilter notGrabbableFilter = lq.ShapeFilter(group: 0, categories: ~grabbableMaskBit, mask: ~grabbableMaskBit);
final lq.ShapeFilter grabFilter = lq.ShapeFilter(group: 0, categories: grabbableMaskBit, mask: grabbableMaskBit);
final lq.ShapeFilter shapeFilterAll = lq.ShapeFilter(group: 0, categories: allCategories, mask: allCategories);
final lq.ShapeFilter shapeFilterNone = lq.ShapeFilter(group: 0, categories: ~allCategories, mask: ~allCategories);

class Game {
  late final lq.Space _space;
  late Ticker _ticker;
  late lq.Body mouseBody;

  lq.Space get space => _space;

  double timeswc = 0;
  Duration _previous = Duration.zero;
  double accuTime = 0;
  double timeStep = 1.0 / 180.0;
  double dt = 0;
  StreamController<double> renderUpdate = StreamController<double>.broadcast();
  void Function(KeyEvent)? keyboardUpdate;
  void Function(double)? physicUpdateBefore;
  void Function(double)? physicUpdateAfter;
  late SpaceMatrix spaceMatrix;
  late InputEvent inputEvent;
  final _random = Random();
  double next(double min, double max) => min + _random.nextDouble() * (max - min);
  mt.Vector2 mouse = mt.Vector2.zero();

  bool paused = false;
  bool isDebugDrawEnable = false;
  Game(double width, double height) : _space = lq.Space() {
    _ticker = Ticker(_tick);
    inputEvent = InputEvent(_keyEvent);
    spaceMatrix = SpaceMatrix(width, height)..run();
    mouseBody = lq.KinematicBody();
  }

  bool _keyEvent(KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      spaceMatrix.x -= 5;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      spaceMatrix.x += 5;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      spaceMatrix.y -= 5;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      spaceMatrix.y += 5;
    } else if (event.logicalKey == LogicalKeyboardKey.keyE) {
      spaceMatrix.scale += 0.01;
    } else if (event.logicalKey == LogicalKeyboardKey.keyQ) {
      spaceMatrix.scale -= 0.01;
    }

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyP) {
        paused = !paused;
      }
    }
    if (keyboardUpdate != null) {
      keyboardUpdate!(event);
    }
    return false;
  }

  void _tick(Duration timestamp) {
    spaceMatrix.run();

    final durationDelta = timestamp - _previous;
    dt = durationDelta.inMicroseconds / Duration.microsecondsPerSecond;
    _previous = timestamp;
    accuTime += dt;
    while (accuTime >= timeStep) {
      if (!paused) {
        var newPoint = mt.Vector2(lerpDouble(mouseBody.p.x, mouse.x, 1) ?? 0, lerpDouble(mouseBody.p.y, mouse.y, 1) ?? 0);
        mouseBody.v = (newPoint - mouseBody.p) * 60;
        mouseBody.p = newPoint;
        if (physicUpdateBefore != null) {
          physicUpdateBefore!(timeStep);
        }
        _space.step(dt: timeStep);
        if (physicUpdateAfter != null) {
          physicUpdateAfter!(timeStep);
        }
      }
      accuTime -= timeStep;
    }
    renderUpdate.add(dt);
  }

  void init(void Function(lq.Space) init) {
    init.call(_space);
  }

  void destroy() {
    inputEvent.destroy();
    _ticker.stop();
    _space.destroy();
  }

  void start() {
    _ticker.start();
  }

  late Color _outlineColor = Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  late Color _constraintColor = Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  late Color _collisionColor = Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  late Color _shapeColor = Color((_random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  void drawDebugPaint(Canvas canvas, Size size) {
    if (isDebugDrawEnable) {
      _space.debugDraw(
          debugDrawCirlceFunc: (pos, angle, radius, outlineColor, fillColor) => _debugDrawCirlceFunc(canvas, size, pos, angle, radius, outlineColor, fillColor),
          debugDrawSegmentFunc: (a, b, color) => _debugDrawSegmentFunc(canvas, size, a, b, color),
          debugDrawFatSegmentFunc: (a, b, radius, outlineColor, fillColor) => _debugDrawFatSegmentFunc(canvas, size, a, b, radius, outlineColor, fillColor),
          debugDrawPolygonFunc: (verts, radius, outlineColor, fillColor) => _debugDrawPolygonFunc(canvas, size, verts, radius, outlineColor, fillColor),
          debugDrawDotFunc: (sized, pos, color) => _debugDrawDotFunc(canvas, size, sized, pos, color),
          debugDrawFlag: lq.DebugDrawFlag.drawShape.value | lq.DebugDrawFlag.drawConstratint.value | lq.DebugDrawFlag.drawCollisionPoint.value,
          colorForShape: _colorForShape,
          shapeOutlineColor: _outlineColor,
          constraintColor: _constraintColor,
          collisionPointColor: _collisionColor);
    }
  }

  void _debugDrawCirlceFunc(Canvas canvas, Size size, mt.Vector2 pos, double angle, double radius, Color outlineColor, Color fillColor) {
    canvas.save();
    _rotate(canvas: canvas, cx: pos.x, cy: -pos.y, angle: -angle);
    canvas.drawCircle(
        Offset(pos.x, -pos.y),
        radius,
        Paint()
          ..color = outlineColor
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(pos.x, -pos.y),
        radius,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill);
    canvas.drawLine(
        Offset(pos.x, -pos.y),
        Offset(pos.x + radius - 1, -pos.y),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1);

    canvas.restore();
  }

  void _rotate({required Canvas canvas, required double cx, required double cy, required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  Color _colorForShape(lq.Shape shape) {
    if (shape.getSensor()) {
      return _shapeColor.withOpacity(.1);
    } else {
      var body = shape.getBody();
      if (body.isSleeping) {
        return Colors.blueGrey;
      } else if (body.sleeping.idleTime > shape.getSpace().getSleepTimeThreshold()) {
        return Colors.blueGrey.shade300;
      } else {
        return _shapeColor;
      }
    }
  }

  void _debugDrawDotFunc(Canvas canvas, Size sizeC, double size, mt.Vector2 pos, Color color) {
    canvas.save();
    canvas.drawCircle(
        Offset(pos.x, -pos.y),
        size,
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..style = PaintingStyle.fill);
    canvas.restore();
  }

  void _debugDrawFatSegmentFunc(Canvas canvas, Size size, mt.Vector2 a, mt.Vector2 b, double radius, Color outlineColor, Color fillColor) {
    canvas.save();

    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = outlineColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }

  void _debugDrawPolygonFunc(Canvas canvas, Size size, List<mt.Vector2> verts, double radius, Color outlineColor, Color fillColor) {
    canvas.save();
    canvas.drawPath(
        _computePath([for (var ele in verts) Offset(ele.x, -ele.y)], radius),
        Paint()
          ..style = PaintingStyle.fill
          ..color = fillColor);
    canvas.drawPath(
        _computePath([for (var ele in verts) Offset(ele.x, -ele.y)], radius),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = outlineColor);

    canvas.restore();
  }

  void _debugDrawSegmentFunc(Canvas canvas, Size size, mt.Vector2 a, mt.Vector2 b, Color color) {
    canvas.save();
    canvas.drawLine(
        Offset(a.x, -a.y),
        Offset(b.x, -b.y),
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.miter);
    canvas.restore();
  }

  Path _computePath(List<Offset> vertices, double radius) {
    final path = Path();
    final length = vertices.length;

    for (int i = 0; i <= length; i++) {
      final src = vertices[i % length];
      final dst = vertices[(i + 1) % length];

      final stepResult = __computeStep(src, dst, radius);
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

  _StepResult __computeStep(Offset a, Offset b, double radius) {
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
