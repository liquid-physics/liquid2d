// ignore_for_file: non_constant_identifier_names, unused_element

part of 'liquid.dart';

extension CpTransformPoint on Matrix4 {
  Vector2 toTransformPoint(Vector2 p) {
    return Vector2(row0.x * p.x + row0.y * p.y + row0.w, row1.x * p.x + row1.y * p.y + row1.w);
  }
}

/// Fast collision filtering type that is used to determine if two objects collide before calling collision or query callbacks.
class ShapeFilter {
  static final Finalizer<Pointer<cpShapeFilter>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  late Pointer<cpShapeFilter> _cpShapeFilter;
  ShapeFilter({required int group, required int categories, required int mask}) : _cpShapeFilter = calloc<cpShapeFilter>() {
    _cpShapeFilter.ref.group = group;
    _cpShapeFilter.ref.categories = categories;
    _cpShapeFilter.ref.mask = mask;
    _finalizer.attach(this, _cpShapeFilter, detach: this);
  }

  Pointer<cpShapeFilter> get toPointer => _cpShapeFilter;

  ShapeFilter._fromPointer(Pointer<cpShapeFilter> filter) {
    _cpShapeFilter = filter;
  }

  /// Two objects with the same non-zero group value do not collide.
  /// This is generally used to group objects in a composite object together to disable self collisions.
  int get group => _cpShapeFilter.ref.group;

  /// A bitmask of user definable categories that this object belongs to.
  /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
  int get categories => _cpShapeFilter.ref.categories;

  /// A bitmask of user definable category types that this object object collides with.
  /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
  int get mask => _cpShapeFilter.ref.mask;

  void close() {
    calloc.free(_cpShapeFilter);
    _finalizer.detach(this);
  }
}

/// Point query info.
class PointQueryInfo {
  static final Finalizer<Pointer<cpPointQueryInfo>> _finalizer = Finalizer((pointer) => calloc.free(pointer));
  late Pointer<cpPointQueryInfo> _pointQueryInfo;
  PointQueryInfo() : _pointQueryInfo = calloc<cpPointQueryInfo>() {
    _pointQueryInfo.ref.point = Vector2.zero().toCpVect().ref;
    _pointQueryInfo.ref.distance = 0;
    _pointQueryInfo.ref.gradient = Vector2.zero().toCpVect().ref;
    _finalizer.attach(this, _pointQueryInfo, detach: this);
  }
  PointQueryInfo._fromPointer(Pointer<cpPointQueryInfo> query) {
    _pointQueryInfo = query;
  }
  Pointer<cpPointQueryInfo> get _toPointer => _pointQueryInfo;

  /// The distance to the point. The distance is negative if the point is inside the shape.
  double get distance => _pointQueryInfo.ref.distance;

  /// The closest point on the shape's surface. (in world space coordinates)
  Vector2 get point => _pointQueryInfo.ref.point.toVector2();

  /// The nearest shape, NULL if no shape was within range.
  Shape get shape => Shape._createDartShape(_pointQueryInfo.ref.shape);

  /// The gradient of the signed distance function.
  /// The value should be similar to info.p/info.d, but accurate even for very small values of info.d.
  Vector2 get gradient => _pointQueryInfo.ref.gradient.toVector2();

  void close() {
    calloc.free(_pointQueryInfo);
    _finalizer.detach(this);
  }
}

/// Segment query info.
class SegmentQueryInfo {
  static final Finalizer<Pointer<cpSegmentQueryInfo>> _finalizer = Finalizer((pointer) => calloc.free(pointer));

  late Pointer<cpSegmentQueryInfo> _segmentQueryInfo;

  SegmentQueryInfo() : _segmentQueryInfo = calloc<cpSegmentQueryInfo>() {
    _finalizer.attach(this, _segmentQueryInfo, detach: this);
  }

  /// The shape that was hit, or NULL if no collision occured.
  Shape get shape => Shape._fromPointer(_segmentQueryInfo.ref.shape);

  /// The normalized distance along the query segment in the range [0, 1].
  Vector2 get normal => _segmentQueryInfo.ref.normal.toVector2();

  /// The point of impact.
  Vector2 get point => _segmentQueryInfo.ref.point.toVector2();

  /// The normalized distance along the query segment in the range [0, 1].
  double get alpha => _segmentQueryInfo.ref.alpha;

  SegmentQueryInfo._fromPointer(Pointer<cpSegmentQueryInfo> query) {
    _segmentQueryInfo = query;
  }

  Pointer<cpSegmentQueryInfo> get _toPointer => _segmentQueryInfo;

  void close() {
    calloc.free(_segmentQueryInfo);
    _finalizer.detach(this);
  }
}

/// An Object that wraps up the important collision data for an arbiter.
class ContactPointSet {
  late final cpContactPointSet _contactPointSet;
  ContactPointSet._fromPointer(cpContactPointSet contactPointSet) : _contactPointSet = contactPointSet;

  /// The number of contact points in the set.
  int get count => _contactPointSet.count;

  /// The normal of the collision.
  Vector2 get normal => _contactPointSet.normal.toVector2();

  /// The list of contact points.
  List<ContactPoint> get points {
    var tmp = <ContactPoint>[];
    for (var i = 0; i < count; i++) {
      tmp.add(ContactPoint(_contactPointSet.points[i].pointA.toVector2(), _contactPointSet.points[i].pointB.toVector2(), _contactPointSet.points[i].distance));
    }
    return tmp;
  }
}

/// contact points.
class ContactPoint {
  /// The position of the contact on the surface of shape A.
  final Vector2 pointA;

  /// The position of the contact on the surface of shape B.
  final Vector2 pointB;

  /// Penetration distance of the two shapes. Overlapping means it will be negative.
  /// This value is calculated as cpvdot(cpvsub(point2, point1), normal) and is ignored by cpArbiterSetContactPointSet().
  final double distance;
  ContactPoint(this.pointA, this.pointB, this.distance);

  ContactPoint copyWith({Vector2? pointA, Vector2? pointB, double? distance}) {
    return ContactPoint(pointA ?? this.pointA, pointB ?? this.pointB, distance ?? this.distance);
  }
}

extension Rect on ui.Rect {
  static ui.Rect fromLBRT(double left, double bottom, double right, double top) {
    return ui.Rect.fromLTRB(left, top, right, bottom);
  }
}

(int count, List<Vector2> verts) quickHull(List<Vector2> verts, double tol) {
  var vv = CpVectArrayRef(verts.length);
  var cc = bindings.cpConvexHull(verts.length, verts.toCpVectList(), vv.toPointer, nullptr, tol);
  return (cc, vv.array);
}

extension CpSleeping on UnnamedStruct1 {
  Sleeping toSleeping() {
    return Sleeping(root: Body._fromPointer(root), next: Body._fromPointer(next), idleTime: idleTime);
  }
}

class Sleeping {
  final Body root;
  final Body next;
  final double idleTime;
  const Sleeping({required this.root, required this.next, required this.idleTime});
}
