import 'package:flutter/material.dart';

abstract class PaintShape {
  const PaintShape();
  void draw(Canvas canvas, Size size);
}
