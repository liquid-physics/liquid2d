// ignore_for_file: non_constant_identifier_names

import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:ui';
import 'package:ffi/ffi.dart';
import 'package:liquid/liquid.dart' as lq;
import 'package:vector_math/vector_math_64.dart';

import 'bindings.dart';

extension CpVectCreate on Vector2 {
  ffi.Pointer<cpVect> toCpVect() {
    return CpVect(x, y).toPointer;
  }

  ffi.Pointer<cpVect> toCpVectS(CpVect c) {
    return c.setData(x, y);
  }
}

extension CpContactPointSetCreate on lq.ContactPointSet {
  ffi.Pointer<cpContactPointSet> toCpContactPointSet() {
    return _cpContactPointSet.setData(this);
  }
}

var _cpArrayContactPointVectorA = CpVect(0, 0);
var _cpArrayContactPointVectorB = CpVect(0, 0);

extension CpArrayContactPoint on Array<UnnamedStruct2> {
  void setArrayContactPoint(lq.ContactPointSet contactPointSet) {
    for (var i = 0; i < contactPointSet.count; i++) {
      this[i].pointA = contactPointSet.points[i].pointA.toCpVectS(_cpArrayContactPointVectorA).ref;
      this[i].pointB = contactPointSet.points[i].pointB.toCpVectS(_cpArrayContactPointVectorB).ref;
      this[i].distance = contactPointSet.points[i].distance;
    }
  }
}

extension CpBBCreate on Rect {
  ffi.Pointer<cpBB> toCpBB() {
    return CpBB(left, bottom, right, top).toPointer;
  }
}

extension CpBBLoad on cpBB {
  Rect toRect() {
    return Rect.fromLTRB(l, t, r, b);
  }
}

extension CpVectCreateList on List<Vector2> {
  ffi.Pointer<cpVect> toCpVectList() {
    return CpVectArray(this).toPointer;
  }
}

extension CpTransform on Matrix4 {
  ffi.Pointer<cpTransform> toCpTransform() {
    return CpTransformF(row0.x, row1.x, row0.y, row1.y, row0.w, row1.w).toPointer;
  }
}

extension CpTransformToMat4 on cpTransform {
  Matrix4 toMatrix4() {
    return Matrix4.columns(Vector4(a, b, 0, 0), Vector4(c, d, 0, 0), Vector4(0, 0, 0, 0), Vector4(tx, ty, 0, 0));
  }
}

extension CpVectLoad on ffi.Pointer<cpVect> {
  Vector2 toVector2() {
    return Vector2(ref.x, ref.y);
  }

  List<Vector2> toVector2List(int count) {
    var tm = List<Vector2>.filled(count, Vector2.zero());
    for (var i = 0; i < count; i++) {
      tm[i] = this[i].toVector2();
    }
    return tm;
  }
}

extension CpVectToVector2 on cpVect {
  Vector2 toVector2() {
    return Vector2(x, y);
  }
}

extension CpShapeFilter on cpShapeFilter {
  lq.ShapeFilter toFilter() {
    return lq.ShapeFilter(group: group, categories: categories, mask: mask);
  }
}

class CpVect {
  static final Finalizer<Pointer<cpVect>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpVect> _cpVect;
  CpVect(double x, double y) : _cpVect = calloc<cpVect>() {
    _cpVect.ref.x = x;
    _cpVect.ref.y = y;
    _finalizer.attach(this, _cpVect, detach: this);
  }

  ffi.Pointer<cpVect> setData(double x, double y) {
    _cpVect.ref.x = x;
    _cpVect.ref.y = y;
    return toPointer;
  }

  ffi.Pointer<cpVect> get toPointer => _cpVect;

  void close() {
    calloc.free(_cpVect);
    _finalizer.detach(this);
  }
}

var _cpContactPointSet = CpContactPointSet();

class CpContactPointSet {
  static final Finalizer<Pointer<cpContactPointSet>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpContactPointSet> _contactPointSet;
  CpContactPointSet() : _contactPointSet = calloc<cpContactPointSet>() {
    _finalizer.attach(this, _contactPointSet, detach: this);
  }
  Pointer<cpContactPointSet> setData(lq.ContactPointSet contactPointSet) {
    _contactPointSet.ref.count = contactPointSet.count;
    _contactPointSet.ref.normal = contactPointSet.normal.toCpVect().ref;
    _contactPointSet.ref.points.setArrayContactPoint(contactPointSet);
    return toPointer;
  }

  ffi.Pointer<cpContactPointSet> get toPointer => _contactPointSet;

  void close() {
    calloc.free(_contactPointSet);
    _finalizer.detach(this);
  }
}

class CpVectArray {
  static final Finalizer<Pointer<cpVect>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpVect> _cpVect;
  CpVectArray(List<Vector2> arr) : _cpVect = calloc.allocate<cpVect>(sizeOf<cpVect>() * arr.length) {
    for (var i = 0; i < arr.length; i++) {
      _cpVect.elementAt(i).ref.x = arr[i].x;
      _cpVect.elementAt(i).ref.y = arr[i].y;
    }
    _finalizer.attach(this, _cpVect, detach: this);
  }

  ffi.Pointer<cpVect> get toPointer => _cpVect;

  void close() {
    calloc.free(_cpVect);
    _finalizer.detach(this);
  }
}

class CpVectArrayRef {
  static final Finalizer<Pointer<cpVect>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final int count;
  final Pointer<cpVect> _arr;
  late List<Vector2> _array;
  CpVectArrayRef(this.count) : _arr = calloc.allocate<cpVect>(sizeOf<cpVect>() * count) {
    _array = List.filled(count, Vector2.zero());
    _finalizer.attach(this, _arr, detach: this);
  }
  ffi.Pointer<cpVect> get toPointer => _arr;
  List<Vector2> get array {
    for (var i = 0; i < count; i++) {
      _array[i] = (Vector2(_arr.elementAt(i).ref.x, _arr.elementAt(i).ref.y));
    }
    return _array;
  }

  void close() {
    calloc.free(_arr);
    _finalizer.detach(this);
  }
}

class CpTransformF {
  static final Finalizer<Pointer<cpTransform>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpTransform> _cpTransform;
  CpTransformF(double a, double b, double c, double d, double tx, double ty) : _cpTransform = calloc<cpTransform>() {
    _cpTransform.ref.a = a;
    _cpTransform.ref.b = b;
    _cpTransform.ref.c = c;
    _cpTransform.ref.d = d;
    _cpTransform.ref.tx = tx;
    _cpTransform.ref.ty = ty;
    _finalizer.attach(this, _cpTransform, detach: this);
  }

  ffi.Pointer<cpTransform> get toPointer => _cpTransform;

  void close() {
    calloc.free(_cpTransform);
    _finalizer.detach(this);
  }
}

class CpBB {
  static final Finalizer<Pointer<cpBB>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpBB> _cpBB;
  CpBB(double left, double bottom, double right, double top) : _cpBB = calloc<cpBB>() {
    _cpBB.ref.l = left;
    _cpBB.ref.b = bottom;
    _cpBB.ref.r = right;
    _cpBB.ref.t = top;
    _finalizer.attach(this, _cpBB, detach: this);
  }
  ffi.Pointer<cpBB> get toPointer => _cpBB;

  void close() {
    calloc.free(_cpBB);
    _finalizer.detach(this);
  }
}

extension BodyTypeExtension on lq.BodyType {
  int toCpBodyType() {
    switch (this) {
      case lq.BodyType.dynamic:
        return cpBodyType.CP_BODY_TYPE_DYNAMIC;
      case lq.BodyType.kinematic:
        return cpBodyType.CP_BODY_TYPE_KINEMATIC;
      case lq.BodyType.static:
        return cpBodyType.CP_BODY_TYPE_STATIC;
    }
  }
}

extension BodyTypeTo on int {
  lq.BodyType toBodyType() {
    switch (this) {
      case 0:
        return lq.BodyType.dynamic;
      case 1:
        return lq.BodyType.kinematic;
      case 2:
        return lq.BodyType.static;
      default:
        throw 'not body type';
    }
  }
}

class CpSpaceDebugColor {
  static final Finalizer<Pointer<cpSpaceDebugColor>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  final Pointer<cpSpaceDebugColor> _cpSpaceDebugColor;
  CpSpaceDebugColor(Color color) : _cpSpaceDebugColor = calloc<cpSpaceDebugColor>() {
    _cpSpaceDebugColor.ref.a = color.alpha / 255;
    _cpSpaceDebugColor.ref.r = color.red / 255;
    _cpSpaceDebugColor.ref.g = color.green / 255;
    _cpSpaceDebugColor.ref.b = color.blue / 255;
    _finalizer.attach(this, _cpSpaceDebugColor, detach: this);
  }

  ffi.Pointer<cpSpaceDebugColor> get toPointer => _cpSpaceDebugColor;

  void close() {
    calloc.free(_cpSpaceDebugColor);
    _finalizer.detach(this);
  }
}
