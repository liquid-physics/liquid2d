// ignore_for_file: constant_identifier_names, unused_element, non_constant_identifier_names

part of 'liquid.dart';

class Shape extends Liquid {
  late final ShapeResources _shape;
  Shape._fromPointerPointer(Pointer<Pointer<cpShape>> shape) : _shape = ShapeResources(shape.value);
  Shape._fromPointer(Pointer<cpShape> shape) : _shape = ShapeResources(shape);
  Pointer<cpShape> get _toPointer => _shape.toPointer;

  /// Destroy a shape.
  void destroy() => _shape.destroy();

  /// Set the elasticity of this shape.
  void setElasticity(double elasticity) => _shape.setElasticity(elasticity);

  /// Set the friction of this shape.
  void setFriction(double friction) => _shape.setFriction(friction);

  /// Set the collision filtering parameters of this shape.
  void setFilter(ShapeFilter filter) => _shape.setFilter(filter);

  /// Set the surface velocity of this shape.
  void setSurfaceVelocity(Vector2 surfaceVelocity) => _shape.setSurfaceVelocity(surfaceVelocity);

  /// The cpBody this shape is connected to.
  Body getBody() => _shape.getBody();

  /// Get the bounding box that contains the shape given it's current position and angle.
  ui.Rect getRect() => _shape.getRect();
  bool get isExist => _shape.isExist;
  int get _type => _shape._type;

  /// Set the collision type of this shape.
  void setCollisionType(int collisionType) => _shape.setCollisionType(collisionType);

  /// Set if the shape is a sensor or not.
  void setSensor(bool sensor) => _shape.setSensor(sensor);

  /// Perform a nearest point query. It finds the closest point on the surface of shape to a specific point.
  /// The value returned is the distance between the points. A negative distance means the point is inside the shape.
  (double distance, PointQueryInfo info) pointQuery({required Vector2 point}) => _shape.pointQuery(point: point);

  /// Get the friction of this shape.
  double getFriction() => _shape.getFriction();

  /// Update, cache and return the bounding box of a shape based on the body it's attached to.
  ui.Rect cacheRect() => _shape.cacheRect();

  /// Update, cache and return the bounding box of a shape with an explicit transformation.
  ui.Rect update(Matrix4 transform) => _shape.update(transform);

  /// Perform a segment query against a shape. @c info must be a pointer to a valid cpSegmentQueryInfo structure.
  (bool result, SegmentQueryInfo info) segmentQuery({required Vector2 a, required Vector2 b, required double radius}) => _shape.segmentQuery(a: a, b: b, radius: radius);

  /// Return contact information about two shapes.
  ContactPointSet collide({required Shape a, required Shape b}) => _shape.collide(a: a, b: b);

  /// The cpSpace this body is added to.
  Space getSpace() => _shape.getSpace();

  /// Set the cpBody this shape is connected to.
  /// Can only be used if the shape is not currently added to a space.
  void setBody(Body body) => _shape.setBody(body);

  /// Get the mass of the shape if you are having Chipmunk calculate mass properties for you.
  double getMass() => _shape.getMass();

  /// Set the mass of this shape to have Chipmunk calculate mass properties for you.
  void setMass(double mass) => _shape.setMass(mass);

  /// Get the density of the shape if you are having Chipmunk calculate mass properties for you.
  double getDensity() => _shape.getDensity();

  /// Set the density  of this shape to have Chipmunk calculate mass properties for you.
  void setDensity(double density) => _shape.setDensity(density);

  /// Get the calculated moment of inertia for this shape.
  double getMoment() => _shape.getMoment();

  /// Get the calculated area of this shape.
  double getArea() => _shape.getArea();

  /// Get the centroid of this shape.
  Vector2 getCenterOfGravity() => _shape.getCenterOfGravity();

  /// Get if the shape is set to be a sensor or not.
  bool getSensor() => _shape.getSensor();

  /// Get the elasticity of this shape.
  double getElasticity() => _shape.getElasticity();

  /// Get the surface velocity of this shape.
  Vector2 getSurfaceVelocity() => _shape.getSurfaceVelocity();

  /// Set the collision type of this shape.
  int getCollisionType() => _shape.getCollisionType();

  /// Get the collision filtering parameters of this shape.
  ShapeFilter getFilter() => _shape.getFilter();

  static Shape _createDartShape(Pointer<cpShape> shape) => ShapeResources._createDartShape(shape);

  @override
  bool operator ==(other) {
    return _type == (other as Shape)._type && _toPointer == other._toPointer;
  }

  @override
  int get hashCode => Object.hash(_type, _toPointer);

  /// Set a user data point associated with this pair of colliding objects.
  void setData<T>(T data) {
    _sh_data[_toPointer.address] = data;
  }

  /// Get the user data pointer associated with this pair of colliding objects.
  T? getData<T>() {
    var q = _sh_data[_toPointer.address];
    if (q != null) {
      return q as T;
    } else {
      return null;
    }
  }

  /// If you need to perform any cleanup for this data, you must do it yourself, in the separate callback for instance.
  void removeData() {
    if (_sh_data.isNotEmpty) {
      _sh_data.remove(_toPointer.address);
    }
  }
}

class ShapeResources {
  late Pointer<cpShape> _shape;

  ShapeResources(this._shape);

  void destroy() {
    if (_shape != nullptr) {
      bindings.cpShapeFree(_shape);
      _shape = nullptr;
    }
  }

  Pointer<cpShape> get toPointer => _shape;

  void setElasticity(double elasticity) {
    bindings.cpShapeSetElasticity(_shape, elasticity);
  }

  void setFriction(double friction) {
    bindings.cpShapeSetFriction(_shape, friction);
  }

  double getFriction() => bindings.cpShapeGetFriction(_shape);

  void setFilter(ShapeFilter filter) {
    bindings.cpShapeSetFilter(_shape, filter.toPointer.ref);
  }

  void setCollisionType(int collisionType) {
    bindings.cpShapeSetCollisionType(_shape, collisionType);
  }

  void setSensor(bool sensor) {
    bindings.cpShapeSetSensor(_shape, sensor ? 1 : 0);
  }

  void setSurfaceVelocity(Vector2 surfaceVelocity) {
    bindings.cpShapeSetSurfaceVelocity(_shape, surfaceVelocity.toCpVect().ref);
  }

  Body getBody() {
    return Body._fromPointer(bindings.cpShapeGetBody(_shape));
  }

  (double distance, PointQueryInfo info) pointQuery({required Vector2 point}) {
    var info = PointQueryInfo();
    return (bindings.cpShapePointQuery(_shape, point.toCpVect().ref, info._toPointer), info);
  }

  ui.Rect getRect() => bindings.cpShapeGetBB(_shape).toRect();

  bool get isExist => _shape != nullptr;
  int get _type => _shape.ref.klass.ref.type;

  static Shape _createDartShape(Pointer<cpShape> shape) {
    switch (shape.ref.klass.ref.type) {
      case cpShapeType.CP_CIRCLE_SHAPE:
        return CircleShape._fromPointer(shape);
      case cpShapeType.CP_SEGMENT_SHAPE:
        return SegmentShape._fromPointer(shape);
      case cpShapeType.CP_POLY_SHAPE:
        Pointer<cpPolyShape> phs = shape.cast<cpPolyShape>();
        if (phs.ref.count == 4) {
          return BoxShape._fromPointer(shape);
        } else {
          return PolyShape._fromPointer(shape);
        }
      default:
        throw 'Shape not found';
    }
  }

  ui.Rect cacheRect() => bindings.cpShapeCacheBB(_shape).toRect();

  ui.Rect update(Matrix4 transform) => bindings.cpShapeUpdate(_shape, transform.toCpTransform().ref).toRect();

  (bool result, SegmentQueryInfo info) segmentQuery({required Vector2 a, required Vector2 b, required double radius}) {
    var info = SegmentQueryInfo();
    return (bindings.cpShapeSegmentQuery(_shape, a.toCpVect().ref, b.toCpVect().ref, radius, info._toPointer) == 0 ? false : true, info);
  }

  ContactPointSet collide({required Shape a, required Shape b}) => ContactPointSet._fromPointer(bindings.cpShapesCollide(a._toPointer, b._toPointer));

  Space getSpace() => Space._fromPointer(bindings.cpShapeGetSpace(_shape));

  void setBody(Body body) => bindings.cpShapeSetBody(_shape, body._toPointer);

  double getMass() => bindings.cpShapeGetMass(_shape);

  void setMass(double mass) => bindings.cpShapeSetMass(_shape, mass);

  double getDensity() => bindings.cpShapeGetDensity(_shape);

  void setDensity(double density) => bindings.cpShapeSetDensity(_shape, density);

  double getMoment() => bindings.cpShapeGetMoment(_shape);

  double getArea() => bindings.cpShapeGetArea(_shape);

  Vector2 getCenterOfGravity() => bindings.cpShapeGetCenterOfGravity(_shape).toVector2();

  bool getSensor() => bindings.cpShapeGetSensor(_shape) == 0 ? false : true;

  double getElasticity() => bindings.cpShapeGetElasticity(_shape);

  Vector2 getSurfaceVelocity() => bindings.cpShapeGetSurfaceVelocity(_shape).toVector2();

  int getCollisionType() => bindings.cpShapeGetCollisionType(_shape);

  ShapeFilter getFilter() => bindings.cpShapeGetFilter(_shape).toFilter();
}

class SegmentShape extends Shape {
  SegmentShape({required Body body, required Vector2 a, required Vector2 b, required double radius})
      : super._fromPointer(bindings.cpSegmentShapeNew(body._toPointer, a.toCpVect().ref, b.toCpVect().ref, radius));

  SegmentShape._fromPointer(Pointer<cpShape> shape) : super._fromPointer(shape);
  Pointer<cpSegmentShape> get _segmentShape => _shape.toPointer.cast<cpSegmentShape>();
  Vector2 get a => _segmentShape.ref.a.toVector2();
  Vector2 get b => _segmentShape.ref.b.toVector2();
  Vector2 get n => _segmentShape.ref.n.toVector2();
  Vector2 get ta => _segmentShape.ref.ta.toVector2();
  Vector2 get tb => _segmentShape.ref.tb.toVector2();
  Vector2 get tn => _segmentShape.ref.tn.toVector2();
  Vector2 get aTangent => _segmentShape.ref.a_tangent.toVector2();
  Vector2 get bTangent => _segmentShape.ref.b_tangent.toVector2();
  double get r => _segmentShape.ref.r;

  /// Let Chipmunk know about the geometry of adjacent segments to avoid colliding with endcaps.
  void setNeighbors({required Vector2 pref, required Vector2 next}) => bindings.cpSegmentShapeSetNeighbors(_shape.toPointer, pref.toCpVect().ref, next.toCpVect().ref);

  /// Get the first endpoint of a segment shape.
  Vector2 getA() => bindings.cpSegmentShapeGetA(_shape.toPointer).toVector2();

  /// Get the second endpoint of a segment shape.
  Vector2 getB() => bindings.cpSegmentShapeGetB(_shape.toPointer).toVector2();

  /// Get the normal of a segment shape.
  Vector2 getNormal() => bindings.cpSegmentShapeGetNormal(_shape.toPointer).toVector2();

  /// Get the first endpoint of a segment shape.
  double getRadius() => bindings.cpSegmentShapeGetRadius(_shape.toPointer);

  /// Set the endpoints of a segment shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setEndpoints({required Vector2 a, required Vector2 b}) => bindings.cpSegmentShapeSetEndpoints(_shape.toPointer, a.toCpVect().ref, b.toCpVect().ref);

  /// Set the radius of a segment shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setRadius(double radius) => bindings.cpSegmentShapeSetRadius(_shape.toPointer, radius);
}

class PolyShape extends Shape {
  PolyShape({required Body body, required List<Vector2> vert, required Matrix4 transform, required double radius})
      : super._fromPointer(bindings.cpPolyShapeNew(body._toPointer, vert.length, vert.toCpVectList(), transform.toCpTransform().ref, radius));

  /// Get the number of verts in a polygon shape.
  int getCount() => bindings.cpPolyShapeGetCount(_shape.toPointer);

  /// Get the @c ith vertex of a polygon shape.
  Vector2 getVert(int index) => bindings.cpPolyShapeGetVert(_shape.toPointer, index).toVector2();

  /// Get the radius of a polygon shape.
  double getRadius() => bindings.cpPolyShapeGetRadius(_shape.toPointer);

  PolyShape._fromPointer(Pointer<cpShape> shape) : super._fromPointer(shape);

  /// Set the vertexes of a poly shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setVerts({required List<Vector2> verts, required Matrix4 transform}) => bindings.cpPolyShapeSetVerts(_shape.toPointer, verts.length, verts.toCpVectList(), transform.toCpTransform().ref);

  /// Set the vertexes of a poly shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setVertsRaw(List<Vector2> verts) => bindings.cpPolyShapeSetVertsRaw(_shape.toPointer, verts.length, verts.toCpVectList());

  /// /// Set the radius of a poly shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setRadius(double radius) => bindings.cpPolyShapeSetRadius(_shape.toPointer, radius);
}

class BoxShape extends PolyShape {
  BoxShape({required Body body, required double width, required double height, required double radius}) : super._fromPointer(bindings.cpBoxShapeNew(body._toPointer, width, height, radius));

  BoxShape.fromRect({required Body body, required ui.Rect rect, required double radius}) : super._fromPointer(bindings.cpBoxShapeNew2(body._toPointer, rect.toCpBB().ref, radius));

  Pointer<cpPolyShape> get _polyShape => _shape.toPointer.cast<cpPolyShape>();

  BoxShape._fromPointer(Pointer<cpShape> shape) : super._fromPointer(shape);
  int get count => _polyShape.ref.count;
  double get r => _polyShape.ref.r;
  Pointer<cpSplittingPlane> get _planes => _polyShape.ref.planes;

  List<Vector2> get verts => [for (int i = 0; i < count; i++) _planes.elementAt(count).ref.v0.toVector2()];
}

class CircleShape extends Shape {
  CircleShape({required Body body, required double radius, required Vector2 offset}) : super._fromPointer(bindings.cpCircleShapeNew(body._toPointer, radius, offset.toCpVect().ref));

  Pointer<cpCircleShape> get _circleShape => _shape.toPointer.cast<cpCircleShape>();

  Vector2 get tc => _circleShape.ref.tc.toVector2();
  Vector2 get c => _circleShape.ref.c.toVector2();
  double get r => _circleShape.ref.r;

  /// Get the offset of a circle shape.
  Vector2 getOffset() => bindings.cpCircleShapeGetOffset(_shape.toPointer).toVector2();

  /// Get the offset of a circle shape.
  double getRadius() => bindings.cpCircleShapeGetRadius(_shape.toPointer);

  /// Set the offset of a circle shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setOffset(Vector2 offset) => bindings.cpCircleShapeSetOffset(_shape.toPointer, offset.toCpVect().ref);

  /// Set the radius of a circle shape.
  ///
  /// This operation is unsafe
  /// In this case "unsafe" is referring to operations which may reduce the
  /// physical accuracy or numerical stability of the simulation, but will not
  /// cause crashes.
  ///  *
  /// The prime example is mutating collision shapes. Chipmunk does not support
  /// this directly. Mutating shapes using this API will caused objects in contact
  /// to be pushed apart using Chipmunk's overlap solver, but not using real
  /// persistent velocities. Probably not what you meant, but perhaps close enough.
  void setRadius(double radius) => bindings.cpCircleShapeSetRadius(_shape.toPointer, radius);

  CircleShape._fromPointer(Pointer<cpShape> shape) : super._fromPointer(shape);
}

class _Moment {
  const _Moment();

  /// Calculate the moment of inertia for a solid box.
  double forBox(double m, double width, double height) => bindings.cpMomentForBox(m, width, height);

  /// Calculate the moment of inertia for a solid box.
  double forBoxRect(double m, ui.Rect rect) => bindings.cpMomentForBox2(m, rect.toCpBB().ref);

  /// Calculate the moment of inertia for a circle.
  /// @c r1 and @c r2 are the inner and outer diameters. A solid circle has an inner diameter of 0.
  double forCircle(double m, double r1, double r2, Vector2 offset) => bindings.cpMomentForCircle(m, r1, r2, offset.toCpVect().ref);

  /// Calculate the moment of inertia for a solid polygon shape assuming it's center of gravity is at it's centroid. The offset is added to each vertex.
  double forPoly(double m, List<Vector2> verts, Vector2 offset, double radius) => bindings.cpMomentForPoly(m, verts.length, verts.toCpVectList(), offset.toCpVect().ref, radius);

  /// Calculate the moment of inertia for a line segment.
  /// Beveling radius is not supported.
  double forSegment(double m, Vector2 a, Vector2 b, double radius) => bindings.cpMomentForSegment(m, a.toCpVect().ref, b.toCpVect().ref, radius);
}

const Moment = _Moment();

class _Area {
  const _Area();

  /// Calculate the signed area of a polygon. A Clockwise winding gives positive area.
  /// This is probably backwards from what you expect, but matches Chipmunk's the winding for poly shapes.
  double forPoly(List<Vector2> verts, double radius) => bindings.cpAreaForPoly(verts.length, verts.toCpVectList(), radius);

  /// Calculate the area of a fattened (capsule shaped) line segment.
  double forSegment(Vector2 a, Vector2 b, double radius) => bindings.cpAreaForSegment(a.toCpVect().ref, b.toCpVect().ref, radius);

  /// Calculate area of a hollow circle.
  /// @c r1 and @c r2 are the inner and outer diameters. A solid circle has an inner diameter of 0.
  double forCircle(double r1, double r2) => bindings.cpAreaForCircle(r1, r2);
}

const Area = _Area();

class _Centeroid {
  const _Centeroid();

  /// Calculate the natural centroid of a polygon.
  Vector2 forPoly(List<Vector2> verts) => bindings.cpCentroidForPoly(verts.length, verts.toCpVectList()).toVector2();
}

const Centeroid = _Centeroid();
final _sh_data = HashMap<int, dynamic>();
