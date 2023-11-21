import 'dart:ui';

import 'package:vector_math/vector_math_64.dart' as mt;

class SpaceMatrix {
  SpaceMatrix(double width, double height)
      : _height = height,
        _width = width;
  double _height;
  double _width;

  void setSize(double width, double height) {
    _height = height;
    _width = width;
  }

  mt.Vector2 get size => mt.Vector2(_width, _height);

  mt.Matrix4 _viewMatrix = mt.Matrix4.identity();
  mt.Matrix4 get viewMatrix => _viewMatrix;
  double x = 0;
  double y = 0;
  double scale = 1;

  mt.Vector2 mouseToView(Offset offset) {
    return mt.Vector2(offset.dx - (_width / 2) - x, _height - offset.dy - (_height / 2) + y) * 1 / scale;
  }

  void run() {
    var viewTranslate = mt.Vector3((_width / 2) + x, (_height / 2) + y, 0);
    _viewMatrix = mt.Matrix4.translation(viewTranslate) * mt.Matrix4.diagonal3(mt.Vector3(scale, scale, 0));
  }
}
