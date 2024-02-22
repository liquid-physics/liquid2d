// ignore_for_file: non_constant_identifier_names

part of 'liquid2d.dart';

enum DebugDrawFlag {
  drawShape(1 << 0),
  drawConstratint(1 << 1),
  drawCollisionPoint(1 << 2);

  const DebugDrawFlag(this.value);
  final int value;
}

class DebugDrawOption {
  static final Finalizer<Pointer<cpSpaceDebugDrawOptions>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpSpaceDebugDrawOptions> _cpDrawOption;

  DebugDrawOption(
      {required void Function(Vector2 pos, double angle, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawCirlceFunc,
      required void Function(Vector2 a, Vector2 b, ui.Color color) debugDrawSegmentFunc,
      required void Function(Vector2 a, Vector2 b, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawFatSegmentFunc,
      required void Function(List<Vector2> verts, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawPolygonFunc,
      required void Function(double size, Vector2 pos, ui.Color color) debugDrawDotFunc,
      required int debugDrawFlag,
      required ui.Color Function(Shape shape) colorForShape,
      required ui.Color shapeOutlineColor,
      required ui.Color constraintColor,
      required ui.Color collisionPointColor})
      : _cpDrawOption = calloc<cpSpaceDebugDrawOptions>() {
    _e_debugDrawCircleOption_callbacks[1] = debugDrawCirlceFunc;
    _e_debugDrawSegmentOption_callbacks[1] = debugDrawSegmentFunc;
    _e_debugDrawFatSegmentOption_callbacks[1] = debugDrawFatSegmentFunc;
    _e_debugDrawPolygonOption_callbacks[1] = debugDrawPolygonFunc;
    _e_debugDrawDotOption_callbacks[1] = debugDrawDotFunc;
    _e_debugcolorForShapeOption_callbacks[1] = colorForShape;

    _cpDrawOption.ref.drawCircle = Pointer.fromFunction(_e_debugDrawCircleOptionCallback);
    _cpDrawOption.ref.drawSegment = Pointer.fromFunction(_e_debugDrawSegmentOptionCallback);
    _cpDrawOption.ref.drawFatSegment = Pointer.fromFunction(_e_debugDrawFatSegmentOptionCallback);
    _cpDrawOption.ref.drawPolygon = Pointer.fromFunction(_e_debugDrawPolygonOptionCallback);
    _cpDrawOption.ref.drawDot = Pointer.fromFunction(_e_debugDrawDotOptionCallback);
    _cpDrawOption.ref.colorForShape = Pointer.fromFunction(_e_debugcolorForShapeOptionCallback);
    _cpDrawOption.ref.flags = debugDrawFlag;
    _cpDrawOption.ref.shapeOutlineColor = CpSpaceDebugColor(shapeOutlineColor).toPointer.ref;
    _cpDrawOption.ref.constraintColor = CpSpaceDebugColor(constraintColor).toPointer.ref;
    _cpDrawOption.ref.collisionPointColor = CpSpaceDebugColor(collisionPointColor).toPointer.ref;
    _cpDrawOption.ref.data = nullptr;

    _finalizer.attach(this, _cpDrawOption, detach: this);
  }
  Pointer<cpSpaceDebugDrawOptions> get toPointer => _cpDrawOption;

  void close() {
    calloc.free(_cpDrawOption);
    _finalizer.detach(this);
  }
}

void _e_debugDrawCircleOptionCallback(cpVect pos, double angle, double radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillcolor, Pointer<Void> data) {
  _e_debugDrawCircleOption_callbacks[1]!.call(
      pos.toVector2(),
      angle,
      radius,
      ui.Color.fromARGB((outlineColor.a * 0xFF).toInt(), (outlineColor.r * 0xFF).toInt(), (outlineColor.g * 0xFF).toInt(), (outlineColor.b * 0xFF).toInt()),
      ui.Color.fromARGB((fillcolor.a * 0xFF).toInt(), (fillcolor.r * 0xFF).toInt(), (fillcolor.g * 0xFF).toInt(), (fillcolor.b * 0xFF).toInt()));
}

void _e_debugDrawSegmentOptionCallback(cpVect a, cpVect b, cpSpaceDebugColor color, Pointer<Void> data) {
  _e_debugDrawSegmentOption_callbacks[1]!.call(a.toVector2(), b.toVector2(), ui.Color.fromARGB((color.a * 0xFF).toInt(), (color.r * 0xFF).toInt(), (color.g * 0xFF).toInt(), (color.b * 0xFF).toInt()));
}

void _e_debugDrawFatSegmentOptionCallback(cpVect a, cpVect b, double radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillcolor, Pointer<Void> data) {
  _e_debugDrawFatSegmentOption_callbacks[1]!.call(
      a.toVector2(),
      b.toVector2(),
      radius,
      ui.Color.fromARGB((outlineColor.a * 0xFF).toInt(), (outlineColor.r * 0xFF).toInt(), (outlineColor.g * 0xFF).toInt(), (outlineColor.b * 0xFF).toInt()),
      ui.Color.fromARGB((fillcolor.a * 0xFF).toInt(), (fillcolor.r * 0xFF).toInt(), (fillcolor.g * 0xFF).toInt(), (fillcolor.b * 0xFF).toInt()));
}

void _e_debugDrawPolygonOptionCallback(int count, Pointer<cpVect> verts, double radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillcolor, Pointer<Void> data) {
  _e_debugDrawPolygonOption_callbacks[1]!.call(
      verts.toVector2List(count),
      radius,
      ui.Color.fromARGB((outlineColor.a * 0xFF).toInt(), (outlineColor.r * 0xFF).toInt(), (outlineColor.g * 0xFF).toInt(), (outlineColor.b * 0xFF).toInt()),
      ui.Color.fromARGB((fillcolor.a * 0xFF).toInt(), (fillcolor.r * 0xFF).toInt(), (fillcolor.g * 0xFF).toInt(), (fillcolor.b * 0xFF).toInt()));
}

void _e_debugDrawDotOptionCallback(double size, cpVect pos, cpSpaceDebugColor color, Pointer<Void> data) {
  _e_debugDrawDotOption_callbacks[1]!.call(size, pos.toVector2(), ui.Color.fromARGB((color.a * 0xFF).toInt(), (color.r * 0xFF).toInt(), (color.g * 0xFF).toInt(), (color.b * 0xFF).toInt()));
}

cpSpaceDebugColor _e_debugcolorForShapeOptionCallback(Pointer<cpShape> shape, Pointer<Void> data) {
  return CpSpaceDebugColor(_e_debugcolorForShapeOption_callbacks[1]!.call(Shape._createDartShape(shape))).toPointer.ref;
}

final _e_debugDrawCircleOption_callbacks = HashMap<int, Function(Vector2 pos, double angle, double radius, ui.Color outlineColor, ui.Color fillColor)>();
final _e_debugDrawSegmentOption_callbacks = HashMap<int, Function(Vector2 a, Vector2 b, ui.Color color)>();
final _e_debugDrawFatSegmentOption_callbacks = HashMap<int, Function(Vector2 a, Vector2 b, double radius, ui.Color outlineColor, ui.Color fillColor)>();
final _e_debugDrawPolygonOption_callbacks = HashMap<int, Function(List<Vector2> verts, double radius, ui.Color outlineColor, ui.Color fillColor)>();
final _e_debugDrawDotOption_callbacks = HashMap<int, Function(double size, Vector2 pos, ui.Color color)>();
final _e_debugcolorForShapeOption_callbacks = HashMap<int, ui.Color Function(Shape shape)>();
