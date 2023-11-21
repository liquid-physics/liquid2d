import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_example/core/game.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:vector_math/vector_math_64.dart' as mt;

class InputW extends StatefulWidget {
  const InputW({super.key, required this.game, required this.child, this.onDoubleTapDown, this.onSecondaryTapDown});

  final Game game;
  final Widget child;
  final void Function(TapDownDetails)? onDoubleTapDown;
  final void Function(TapDownDetails)? onSecondaryTapDown;

  @override
  State<InputW> createState() => _InputWState();
}

class _InputWState extends State<InputW> {
  lq.PivotJoint? mouseJoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) {
          widget.game.mouse = widget.game.spaceMatrix.mouseToView(details.localPosition);
        },
        onDoubleTapDown: widget.onDoubleTapDown,
        onSecondaryTapDown: widget.onSecondaryTapDown,
        onPanStart: (details) {
          widget.game.mouse = widget.game.spaceMatrix.mouseToView(details.localPosition);
          double radius = 5;
          var (lq.Shape sh, lq.PointQueryInfo info) = widget.game.space.pointQueryNearest(mouse: widget.game.spaceMatrix.mouseToView(details.localPosition), radius: radius, filter: grabFilter);

          if (sh.isExist) {
            if (sh.getBody().getMass() < double.infinity) {
              mt.Vector2 nearest = (info.distance > 0 ? info.point : widget.game.spaceMatrix.mouseToView(details.localPosition));

              var body = sh.getBody();
              mouseJoint = lq.PivotJoint(a: widget.game.mouseBody, b: body, anchorA: mt.Vector2.zero(), anchorB: body.worldToLocal(nearest))
                ..maxForce = 50000
                ..errorBias = pow(1 - .15, 60).toDouble();

              widget.game.space.addConstraint(constraint: mouseJoint!);
            }
          }
        },
        onPanEnd: (event) {
          if (mouseJoint != null) {
            widget.game.space.removeConstraint(constraint: mouseJoint!);
            mouseJoint!.destroy();
          }
        },
        child: widget.child);
  }
}
