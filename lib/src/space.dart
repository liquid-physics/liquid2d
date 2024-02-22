// ignore_for_file: non_constant_identifier_names

part of 'liquid2d.dart';

class Space extends liquid2d {
  late final SpaceResource _space;
  Space() : _space = SpaceResource(bindings.cpSpaceNew());
  Space._fromPointer(Pointer<cpSpace> space) : _space = SpaceResource(space);
  Pointer<cpSpace> get _toPointer => _space.toPointer;

  /// Destroy a Space.
  void destroy() => _space.destroy();

  /// Step the space forward in time by @c dt.
  void step({required double dt}) => _space.step(dt: dt);

  /// Number of iterations to use in the impulse solver to solve contacts and other constraints.
  void setIternation({required int iterations}) => _space.setIternation(iterations: iterations);

  /// Number of iterations to use in the impulse solver to solve contacts and other constraints.
  int getIterations() => _space.getIterations();

  /// Gravity to pass to rigid bodies when integrating velocity.
  void setGravity({required Vector2 gravity}) => _space.setGravity(gravity: gravity);

  /// Gravity to pass to rigid bodies when integrating velocity.
  Vector2 getGravity() => _space.getGravity();

  /// Damping rate expressed as the fraction of velocity bodies retain each second.
  /// A value of 0.9 would mean that each body's velocity will drop 10% per second.
  /// The default value is 1.0, meaning no damping is applied.
  /// @note This damping value is different than those of cpDampedSpring and cpDampedRotarySpring.
  void setDamping({required double damping}) => _space.setDamping(damping: damping);

  /// Damping rate expressed as the fraction of velocity bodies retain each second.
  /// A value of 0.9 would mean that each body's velocity will drop 10% per second.
  /// The default value is 1.0, meaning no damping is applied.
  /// @note This damping value is different than those of cpDampedSpring and cpDampedRotarySpring.
  double getDamping() => _space.getDamping();

  /// Time a group of bodies must remain idle in order to fall asleep.
  /// Enabling sleeping also implicitly enables the the contact graph.
  /// The default value of INFINITY disables the sleeping algorithm.
  void setSleepTimeThreshold({required double sleepTimeThreshold}) => _space.setSleepTimeThreshold(sleepTimeThreshold: sleepTimeThreshold);

  /// Time a group of bodies must remain idle in order to fall asleep.
  /// Enabling sleeping also implicitly enables the the contact graph.
  /// The default value of INFINITY disables the sleeping algorithm.
  double getSleepTimeThreshold() => _space.getSleepTimeThreshold();

  /// Amount of encouraged penetration between colliding shapes.
  /// Used to reduce oscillating contacts and keep the collision cache warm.
  /// Defaults to 0.1. If you have poor simulation quality,
  /// increase this number as much as possible without allowing visible amounts of overlap.
  void setCollisionSlop({required double collisionSlop}) => _space.setCollisionSlop(collisionSlop: collisionSlop);

  /// Amount of encouraged penetration between colliding shapes.
  /// Used to reduce oscillating contacts and keep the collision cache warm.
  /// Defaults to 0.1. If you have poor simulation quality,
  /// increase this number as much as possible without allowing visible amounts of overlap.
  double getCollisionSlop() => _space.getCollisionSlop();

  /// The Space provided static body for a given cpSpace.
  /// This is merely provided for convenience and you are not required to use it.
  Body getStaticBody() => _space.getStaticBody();

  /// Add a collision shape to the simulation.
  /// If the shape is attached to a static body, it will be added as a static shape.
  Shape addShape({required Shape shape}) => _space.addShape(shape: shape);

  /// Add a rigid body to the simulation.
  Body addBody({required Body body}) => _space.addBody(body: body);

  /// Add a constraint to the simulation.
  T addConstraint<T extends Constraint>({required T constraint}) => _space.addConstraint<T>(constraint: constraint);

  /// Call @c func for each shape in the space.
  void eachShape(void Function(Shape shape) shapeFunc) => _space.eachShape(shapeFunc);

  /// Call @c func for each body in the space.
  void eachBody(void Function(Body body) bodyFunc) => _space.eachBody(bodyFunc);

  /// Switch the space to use a spatial has as it's spatial index.
  void useSpatialHash({required double dim, required int count}) => _space.useSpatialHash(dim: dim, count: count);

  /// Query the space at a point and return the nearest shape found. Returns NULL if no shapes were found.
  (Shape shape, PointQueryInfo info) pointQueryNearest({required Vector2 mouse, required double radius, required ShapeFilter filter}) =>
      _space.pointQueryNearest(mouse: mouse, radius: radius, filter: filter);

  /// Perform a directed line segment query (like a raycast) against the space and return the first shape hit. Returns NULL if no shapes were hit.
  (Shape shape, SegmentQueryInfo info) segmentQueryFirst({required Vector2 start, required Vector2 end, required double radius, required ShapeFilter filter}) =>
      _space.segmentQueryFirst(start: start, end: end, radius: radius, filter: filter);

  /// Remove a constraint from the simulation.
  void removeConstraint({required Constraint constraint}) => _space.removeConstraint(constraint: constraint);

  /// Create or return the existing wildcard collision handler for the specified type.
  CollisionHandler addWildcardHandler({required int type}) => _space.addWildcardHandler(type: type);

  /// Create or return the existing collision handler for the specified pair of collision types.
  /// If wildcard handlers are used with either of the collision types, it's the responibility of the custom handler to invoke the wildcard handlers.
  CollisionHandler addCollisionHandler({required int aType, required int bType}) => _space.addCollisionHandler(aType: aType, bType: bType);

  /// Returns the current (or most recent) time step used with the given space.
  /// Useful from callbacks if your time step is not a compile-time global.
  double getCurrentTimeStep() => _space.getCurrentTimeStep();

  /// Schedule a post-step callback to be called when cpSpaceStep() finishes.
  /// You can only register one callback per unique value for @c key.
  /// Returns true only if @c key has never been scheduled before.
  /// It's possible to pass @c NULL for @c func if you only want to mark @c key as being used.
  bool addPostStepCallback<T>(T liquid2dType, void Function(Space space, T liquid2dType) postStepFunc) => _space.addPostStepCallback<T>(liquid2dType, postStepFunc);

  /// Perform a directed line segment query (like a raycast) against the space calling @c func for each shape intersected.
  void segmentQuery(
          {required Vector2 start,
          required Vector2 end,
          required double radius,
          required ShapeFilter filter,
          required void Function(Shape shape, Vector2 point, Vector2 normal, double alpha) queryFunc}) =>
      _space.segmentQuery(start: start, end: end, radius: radius, filter: filter, queryFunc: queryFunc);

  /// Remove a collision shape from the simulation.
  void removeShape({required Shape shape}) => _space.removeShape(shape: shape);

  /// Remove a rigid body from the simulation.
  void removeBody({required Body body}) => _space.removeBody(body: body);

  /// Speed threshold for a body to be considered idle.
  /// The default value of 0 means to let the space guess a good threshold based on gravity.
  double getIdleSpeedThreshold() => _space.getIdleSpeedThreshold();

  /// Speed threshold for a body to be considered idle.
  /// The default value of 0 means to let the space guess a good threshold based on gravity.
  void setIdleSpeedThreshold(double idleSpeedThreshold) => _space.setIdleSpeedThreshold(idleSpeedThreshold);

  /// Determines how fast overlapping shapes are pushed apart.
  /// Expressed as a fraction of the error remaining after each second.
  /// Defaults to pow(1.0 - 0.1, 60.0) meaning that Chipmunk fixes 10% of overlap each frame at 60Hz.
  double getCollisionBias() => _space.getCollisionBias();

  /// Determines how fast overlapping shapes are pushed apart.
  /// Expressed as a fraction of the error remaining after each second.
  /// Defaults to pow(1.0 - 0.1, 60.0) meaning that Chipmunk fixes 10% of overlap each frame at 60Hz.
  void setCollisionBias(double collisionBias) => _space.setCollisionBias(collisionBias);

  /// Number of frames that contact information should persist.
  /// Defaults to 3. There is probably never a reason to change this value.
  int getCollisionPersistence() => _space.getCollisionPersistence();

  /// Number of frames that contact information should persist.
  /// Defaults to 3. There is probably never a reason to change this value.
  void setCollisionPersistence(int collisionPersistence) => _space.setCollisionPersistence(collisionPersistence);

  /// User definable data pointer.
  /// Generally this points to your game's controller or game state
  /// class so you can access it when given a cpSpace reference in a callback.
  void setData<T>(T data) {
    _sp_data[_toPointer.address] = data;
  }

  /// User definable data pointer.
  /// Generally this points to your game's controller or game state
  /// class so you can access it when given a cpSpace reference in a callback.
  T? getData<T>() {
    var q = _sp_data[_toPointer.address];
    if (q != null) {
      return q as T;
    } else {
      return null;
    }
  }

  /// User definable data pointer.
  /// Generally this points to your game's controller or game state
  /// class so you can access it when given a cpSpace reference in a callback.
  void removeData() {
    if (_sp_data.isNotEmpty) {
      _sp_data.remove(_toPointer.address);
    }
  }

  /// returns true from inside a callback when objects cannot be added/removed.
  bool get isLocked => _space.isLocked;

  /// Create or return the existing collision handler that is called for all collisions that are not handled by a more specific collision handler.
  CollisionHandler addDefaultCollisionHandler() => _space.addDefaultCollisionHandler();

  /// Test if a collision shape has been added to the space.
  bool isContainsShape(Shape shape) => _space.isContainsShape(shape);

  /// Test if a rigid body has been added to the space.
  bool isContainsBody(Body body) => _space.isContainsBody(body);

  /// Test if a constraint has been added to the space.
  bool isContainsConstraint(Constraint constraint) => _space.isContainsConstraint(constraint);

  /// Query the space at a point and call @c func for each shape found.
  void pointQuery(
          {required Vector2 point, required double maxDistance, required ShapeFilter filter, required void Function(Shape shape, Vector2 point, double distance, Vector2 gradient) pointQueryFunc}) =>
      _space.pointQuery(point: point, maxDistance: maxDistance, filter: filter, pointQueryFunc: pointQueryFunc);

  /// Perform a fast rectangle query on the space calling @c func for each shape found.
  /// Only the shape's bounding boxes are checked for overlap, not their full shape.
  void rectQuery({required ui.Rect rect, required ShapeFilter filter, required void Function(Shape shape) rectQueryFunc}) => _space.rectQuery(rect: rect, filter: filter, rectQueryFunc: rectQueryFunc);

  /// Query a space for any shapes overlapping the given shape and call @c func for each shape found.
  bool shapeQuery({required Shape shape, required void Function(Shape shape, ContactPointSet points) shapeQueryFunc}) => _space.shapeQuery(shape: shape, shapeQueryFunc: shapeQueryFunc);

  /// Call @c func for each shape in the space.
  void eachConstraint(void Function(Constraint constraint) constraintFunc) => _space.eachConstraint(constraintFunc);

  /// Update the collision detection info for the static shapes in the space.
  void reindexStatic() => _space.reindexStatic();

  /// Update the collision detection data for a specific shape in the space.
  void reindexShape(Shape shape) => _space.reindexShape(shape);

  /// Update the collision detection data for all shapes attached to a body.
  void reindexShapeForBody(Body body) => _space.reindexShapeForBody(body);

  /// Debug draw the current state of the space using the supplied drawing options.
  void debugDraw(
      {required void Function(Vector2 pos, double angle, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawCirlceFunc,
      required void Function(Vector2 a, Vector2 b, ui.Color color) debugDrawSegmentFunc,
      required void Function(Vector2 a, Vector2 b, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawFatSegmentFunc,
      required void Function(List<Vector2> verts, double radius, ui.Color outlineColor, ui.Color fillColor) debugDrawPolygonFunc,
      required void Function(double size, Vector2 pos, ui.Color color) debugDrawDotFunc,
      required int debugDrawFlag,
      required ui.Color Function(Shape shape) colorForShape,
      required ui.Color shapeOutlineColor,
      required ui.Color constraintColor,
      required ui.Color collisionPointColor}) {
    _space.debugDraw(DebugDrawOption(
        debugDrawCirlceFunc: debugDrawCirlceFunc,
        debugDrawSegmentFunc: debugDrawSegmentFunc,
        debugDrawFatSegmentFunc: debugDrawFatSegmentFunc,
        debugDrawPolygonFunc: debugDrawPolygonFunc,
        debugDrawDotFunc: debugDrawDotFunc,
        debugDrawFlag: debugDrawFlag,
        colorForShape: colorForShape,
        shapeOutlineColor: shapeOutlineColor,
        constraintColor: constraintColor,
        collisionPointColor: collisionPointColor));
  }
}

class SpaceResource {
  final Pointer<cpSpace> _space;
  SpaceResource(this._space);
  Pointer<cpSpace> get toPointer => _space;

  bool get isLocked => bindings.cpSpaceIsLocked(_space) == 0 ? false : true;

  void destroy() {
    bindings.cpSpaceEachShape(_space, Pointer.fromFunction(postShapeFree), _space.cast<Void>(), 0);
    bindings.cpSpaceEachConstraint(_space, Pointer.fromFunction(postConstraintFree), _space.cast<Void>(), 0);
    bindings.cpSpaceEachBody(_space, Pointer.fromFunction(postBodyFree), _space.cast<Void>(), 0);
    bindings.cpSpaceFree(_space);
    _cleanUpCallback();
  }

  void _cleanUpCallback() {
    _eachShape_callbacks.clear();
    _eachBody_callbacks.clear();
    _addPostStepCallback_callbacks_constraint.clear();
    _addPostStepCallback_callbacks_shape.clear();
    _addPostStepCallback_callbacks_space.clear();
    _addPostStepCallback_callbacks_body.clear();
    _s_segmentQuery_callbacks.clear();
    _s_pointQuery_callbacks.clear();
    _s_rectQuery_callbacks.clear();
    _s_shapeQuery_callbacks.clear();
    _s_eachConstraint_callbacks.clear();
  }

  void step({required double dt}) {
    bindings.cpSpaceStep(_space, dt);
  }

  void setIternation({required int iterations}) {
    bindings.cpSpaceSetIterations(_space, iterations);
  }

  void setGravity({required Vector2 gravity}) {
    bindings.cpSpaceSetGravity(_space, gravity.toCpVect().ref);
  }

  Vector2 getGravity() {
    return bindings.cpSpaceGetGravity(_space).toVector2();
  }

  void setDamping({required double damping}) {
    bindings.cpSpaceSetDamping(_space, damping);
  }

  void setSleepTimeThreshold({required double sleepTimeThreshold}) {
    bindings.cpSpaceSetSleepTimeThreshold(_space, sleepTimeThreshold);
  }

  void setCollisionSlop({required double collisionSlop}) {
    bindings.cpSpaceSetCollisionSlop(_space, collisionSlop);
  }

  Body getStaticBody() {
    return Body._fromPointer(bindings.cpSpaceGetStaticBody(_space));
  }

  Shape addShape({required Shape shape}) {
    var shp = bindings.cpSpaceAddShape(_space, shape._toPointer);
    return Shape._createDartShape(shp);
  }

  double getCurrentTimeStep() => bindings.cpSpaceGetCurrentTimeStep(_space);

  Body addBody({required Body body}) {
    return Body._fromPointer(bindings.cpSpaceAddBody(_space, body._toPointer));
  }

  T addConstraint<T extends Constraint>({required T constraint}) {
    var cons = bindings.cpSpaceAddConstraint(_space, constraint._toPointer);
    return Constraint._createDartConstraint(cons) as T;
  }

  void eachShape(void Function(Shape shape) shapeFunc) {
    var cId = __calbackIdGen(_space.address, 'eachShape');
    _eachShape_callbacks[cId] = shapeFunc;
    bindings.cpSpaceEachShape(_space, Pointer.fromFunction(eachShapeCallback), nullptr, cId);
  }

  void eachBody(void Function(Body body) bodyFunc) {
    var cId = __calbackIdGen(_space.address, 'eachBody');
    _eachBody_callbacks[cId] = bodyFunc;
    bindings.cpSpaceEachBody(_space, Pointer.fromFunction(eachBodyCallback), nullptr, cId);
  }

  void useSpatialHash({required double dim, required int count}) {
    bindings.cpSpaceUseSpatialHash(_space, dim, count);
  }

  (Shape shape, PointQueryInfo info) pointQueryNearest({required Vector2 mouse, required double radius, required ShapeFilter filter}) {
    var info = PointQueryInfo();
    var sh = bindings.cpSpacePointQueryNearest(_space, mouse.toCpVect().ref, radius, filter.toPointer.ref, info._toPointer);

    return (Shape._fromPointer(sh), info);
  }

  (Shape shape, SegmentQueryInfo info) segmentQueryFirst({required Vector2 start, required Vector2 end, required double radius, required ShapeFilter filter}) {
    var info = SegmentQueryInfo();
    var sh = bindings.cpSpaceSegmentQueryFirst(_space, start.toCpVect().ref, end.toCpVect().ref, radius, filter.toPointer.ref, info._toPointer);
    return (Shape._fromPointer(sh), info);
  }

  void segmentQuery(
      {required Vector2 start, required Vector2 end, required double radius, required ShapeFilter filter, required void Function(Shape shape, Vector2 point, Vector2 normal, double alpha) queryFunc}) {
    var cId = __calbackIdGen(_space.address, 'segmentQuery');
    _s_segmentQuery_callbacks[cId] = queryFunc;
    bindings.cpSpaceSegmentQuery(_space, start.toCpVect().ref, end.toCpVect().ref, radius, filter.toPointer.ref, Pointer.fromFunction(_s_segmentQueryCallback), nullptr, cId);
  }

  void removeConstraint({required Constraint constraint}) {
    if (constraint.isExist && bindings.cpSpaceContainsConstraint(_space, constraint._toPointer) == 1 ? true : false) {
      bindings.cpSpaceRemoveConstraint(_space, constraint._toPointer);
      constraint.destroy();
    }
  }

  void removeShape({required Shape shape}) {
    if (shape.isExist && bindings.cpSpaceContainsShape(_space, shape._toPointer) == 1 ? true : false) {
      bindings.cpSpaceRemoveShape(_space, shape._toPointer);
      shape.destroy();
    }
  }

  void removeBody({required Body body}) {
    if (body.isExist && bindings.cpSpaceContainsBody(_space, body._toPointer) == 1 ? true : false) {
      bindings.cpSpaceRemoveBody(_space, body._toPointer);
      body.destroy();
    }
  }

  CollisionHandler addWildcardHandler({required int type}) {
    return CollisionHandler._fromPointerSpaceAddWildcardHandler(_space, type);
  }

  CollisionHandler addCollisionHandler({required int aType, required int bType}) {
    return CollisionHandler._fromPointerSpaceAddCollisionHandler(_space, aType, bType);
  }

  bool addPostStepCallback<T>(T liquid2dType, void Function(Space space, T liquid2dType) postStepFunc) {
    if (liquid2dType is Constraint) {
      var cId = __calbackIdGen(_space.address, 'addPostStepCallbackConstraint');
      _addPostStepCallback_callbacks_constraint[cId] = postStepFunc as void Function(Space space, Constraint liquid2dType);
      return bindings.cpSpaceAddPostStepCallback(_space, Pointer.fromFunction(_s_addPostStepCallback), (liquid2dType)._toPointer.cast<Void>(), nullptr, cId) == 1 ? true : false;
    }
    if (liquid2dType is Body) {
      var cId = __calbackIdGen(_space.address, 'addPostStepCallbackBody');
      _addPostStepCallback_callbacks_body[cId] = postStepFunc as void Function(Space space, Body liquid2dType);
      return bindings.cpSpaceAddPostStepCallback(_space, Pointer.fromFunction(_s_addPostStepCallback), (liquid2dType)._toPointer.cast<Void>(), nullptr, cId) == 1 ? true : false;
    }
    if (liquid2dType is Space) {
      var cId = __calbackIdGen(_space.address, 'addPostStepCallbackSpace');
      _addPostStepCallback_callbacks_space[cId] = postStepFunc as void Function(Space space, Space liquid2dType);
      return bindings.cpSpaceAddPostStepCallback(_space, Pointer.fromFunction(_s_addPostStepCallback), (liquid2dType)._toPointer.cast<Void>(), nullptr, cId) == 1 ? true : false;
    }
    if (liquid2dType is Shape) {
      var cId = __calbackIdGen(_space.address, 'addPostStepCallbackShape');
      _addPostStepCallback_callbacks_shape[cId] = postStepFunc as void Function(Space space, Shape liquid2dType);
      return bindings.cpSpaceAddPostStepCallback(_space, Pointer.fromFunction(_s_addPostStepCallback), (liquid2dType)._toPointer.cast<Void>(), nullptr, cId) == 1 ? true : false;
    }
    throw 'error';
  }

  int getIterations() => bindings.cpSpaceGetIterations(_space);

  double getDamping() => bindings.cpSpaceGetDamping(_space);

  double getIdleSpeedThreshold() => bindings.cpSpaceGetIdleSpeedThreshold(_space);

  void setIdleSpeedThreshold(double idleSpeedThreshold) => bindings.cpSpaceSetIdleSpeedThreshold(_space, idleSpeedThreshold);

  double getSleepTimeThreshold() => bindings.cpSpaceGetSleepTimeThreshold(_space);

  double getCollisionSlop() => bindings.cpSpaceGetCollisionSlop(_space);

  double getCollisionBias() => bindings.cpSpaceGetCollisionBias(_space);

  void setCollisionBias(double collisionBias) => bindings.cpSpaceSetCollisionBias(_space, collisionBias);

  int getCollisionPersistence() => bindings.cpSpaceGetCollisionPersistence(_space);

  void setCollisionPersistence(int collisionPersistence) => bindings.cpSpaceSetCollisionPersistence(_space, collisionPersistence);

  bool isContainsShape(Shape shape) => bindings.cpSpaceContainsShape(_space, shape._toPointer) == 0 ? false : true;

  bool isContainsBody(Body body) => bindings.cpSpaceContainsBody(_space, body._toPointer) == 0 ? false : true;

  bool isContainsConstraint(Constraint constraint) => bindings.cpSpaceContainsConstraint(_space, constraint._toPointer) == 0 ? false : true;

  CollisionHandler addDefaultCollisionHandler() {
    return CollisionHandler._fromPointerSpaceAddDefaultCollisionHandler(_space);
  }

  void pointQuery(
      {required Vector2 point, required double maxDistance, required ShapeFilter filter, required void Function(Shape shape, Vector2 point, double distance, Vector2 gradient) pointQueryFunc}) {
    var cId = __calbackIdGen(_space.address, 'pointQuery');
    _s_pointQuery_callbacks[cId] = pointQueryFunc;
    bindings.cpSpacePointQuery(_space, point.toCpVect().ref, maxDistance, filter.toPointer.ref, Pointer.fromFunction(_s_pointQueryCallback), nullptr, cId);
  }

  void rectQuery({required ui.Rect rect, required ShapeFilter filter, required void Function(Shape shape) rectQueryFunc}) {
    var cId = __calbackIdGen(_space.address, 'rectQuery');
    _s_rectQuery_callbacks[cId] = rectQueryFunc;
    bindings.cpSpaceBBQuery(_space, rect.toCpBB().ref, filter.toPointer.ref, Pointer.fromFunction(_s_rectQueryCallback), nullptr, cId);
  }

  bool shapeQuery({required Shape shape, required void Function(Shape shape, ContactPointSet points) shapeQueryFunc}) {
    var cId = __calbackIdGen(_space.address, 'shapeQuery');
    _s_shapeQuery_callbacks[cId] = shapeQueryFunc;
    return bindings.cpSpaceShapeQuery(_space, shape._toPointer, Pointer.fromFunction(_s_shapeQueryCallback), nullptr, cId) == 0 ? false : true;
  }

  void eachConstraint(void Function(Constraint constraint) constraintFunc) {
    var cId = __calbackIdGen(_space.address, 'eachConstraint');
    _s_eachConstraint_callbacks[cId] = constraintFunc;
    bindings.cpSpaceEachConstraint(_space, Pointer.fromFunction(_s_eachConstraintCallback), nullptr, cId);
  }

  void reindexStatic() => bindings.cpSpaceReindexStatic(_space);

  void reindexShape(Shape shape) => bindings.cpSpaceReindexShape(_space, shape._toPointer);

  void reindexShapeForBody(Body body) => bindings.cpSpaceReindexShapesForBody(_space, body._toPointer);

  void debugDraw(DebugDrawOption options) {
    bindings.cpSpaceDebugDraw(_space, options.toPointer);
  }
}

void _s_segmentQueryCallback(Pointer<cpShape> shape, cpVect point, cpVect normal, double alpha, Pointer<Void> data, int callbackId) {
  _s_segmentQuery_callbacks[callbackId]!.call(Shape._createDartShape(shape), point.toVector2(), normal.toVector2(), alpha);
}

void _s_pointQueryCallback(Pointer<cpShape> shape, cpVect point, double distance, cpVect gradient, Pointer<Void> data, int callbackId) {
  _s_pointQuery_callbacks[callbackId]!.call(Shape._createDartShape(shape), point.toVector2(), distance, gradient.toVector2());
}

void _s_rectQueryCallback(Pointer<cpShape> shape, Pointer<Void> data, int callbackId) {
  _s_rectQuery_callbacks[callbackId]!.call(Shape._createDartShape(shape));
}

void _s_shapeQueryCallback(Pointer<cpShape> shape, Pointer<cpContactPointSet> points, Pointer<Void> data, int callbackId) {
  _s_shapeQuery_callbacks[callbackId]!.call(Shape._createDartShape(shape), ContactPointSet._fromPointer(points.ref));
}

void _s_eachConstraintCallback(Pointer<cpConstraint> constraint, Pointer<Void> data, int callbackId) {
  _s_eachConstraint_callbacks[callbackId]!.call(Constraint._createDartConstraint(constraint));
}

void eachBodyCallback(Pointer<cpBody> body, Pointer<Void> data, int callbackId) {
  _eachBody_callbacks[callbackId]!.call(Body._fromPointer(body));
}

void eachShapeCallback(Pointer<cpShape> shape, Pointer<Void> data, int callbackId) {
  _eachShape_callbacks[callbackId]!.call(Shape._createDartShape(shape));
}

void _s_addPostStepCallback(Pointer<cpSpace> space, Pointer<Void> key, Pointer<Void> data, int callbackId) {
  if (_addPostStepCallback_callbacks_constraint.isNotEmpty) {
    var fn = _addPostStepCallback_callbacks_constraint[callbackId]!;
    fn.call(Space._fromPointer(space), Constraint._fromPointer(key.cast<cpConstraint>()));
  }

  if (_addPostStepCallback_callbacks_body.isNotEmpty) {
    var fn = _addPostStepCallback_callbacks_body[callbackId]!;
    fn.call(Space._fromPointer(space), Body._fromPointer(key.cast<cpBody>()));
  }

  if (_addPostStepCallback_callbacks_space.isNotEmpty) {
    var fn = _addPostStepCallback_callbacks_space[callbackId]!;
    fn.call(Space._fromPointer(space), Space._fromPointer(key.cast<cpSpace>()));
  }

  if (_addPostStepCallback_callbacks_shape.isNotEmpty) {
    var fn = _addPostStepCallback_callbacks_shape[callbackId]!;
    fn.call(Space._fromPointer(space), Shape._createDartShape(key.cast<cpShape>()));
  }
}

extension Aho<T> on Map<int, void Function(Space, T)> {
  void addEntriesType(Iterable<MapEntry<int, void Function(Space, T)>> newEntries) {
    addEntries(newEntries);
  }
}

void postShapeFree(Pointer<cpShape> shape, Pointer<Void> space, int unused) {
  bindings.cpSpaceAddPostStepCallback(space as Pointer<cpSpace>, Pointer.fromFunction(shapeFreeWrap), shape.cast<Void>(), nullptr, 0);
}

void shapeFreeWrap(Pointer<cpSpace> space, Pointer<Void> shape, Pointer<Void> unused, int callbackId) {
  bindings.cpSpaceRemoveShape(space, shape as Pointer<cpShape>);
  bindings.cpShapeFree(shape as Pointer<cpShape>);
}

void postConstraintFree(Pointer<cpConstraint> constraint, Pointer<Void> space, int callbackId) {
  bindings.cpSpaceAddPostStepCallback(space as Pointer<cpSpace>, Pointer.fromFunction(constraintFreeWrap), constraint.cast<Void>(), nullptr, 0);
}

void constraintFreeWrap(Pointer<cpSpace> space, Pointer<Void> constraint, Pointer<Void> unused, int callbackId) {
  bindings.cpSpaceRemoveConstraint(space, constraint as Pointer<cpConstraint>);
  bindings.cpConstraintFree(constraint as Pointer<cpConstraint>);
}

void bodyFreeWrap(Pointer<cpSpace> space, Pointer<Void> body, Pointer<Void> unused, int callbacId) {
  bindings.cpSpaceRemoveBody(space, body as Pointer<cpBody>);
  bindings.cpBodyFree(body as Pointer<cpBody>);
}

void postBodyFree(Pointer<cpBody> body, Pointer<Void> space, int unused) {
  bindings.cpSpaceAddPostStepCallback(space as Pointer<cpSpace>, Pointer.fromFunction(bodyFreeWrap), body.cast<Void>(), nullptr, 0);
}

final _eachShape_callbacks = HashMap<int, Function(Shape)>();
final _eachBody_callbacks = HashMap<int, Function(Body)>();

final _addPostStepCallback_callbacks_constraint = addcllc<Constraint>();
final _addPostStepCallback_callbacks_shape = addcllc<Shape>();
final _addPostStepCallback_callbacks_space = addcllc<Space>();
final _addPostStepCallback_callbacks_body = addcllc<Body>();

final _s_segmentQuery_callbacks = HashMap<int, Function(Shape shape, Vector2 point, Vector2 normal, double alpha)>();
final _s_pointQuery_callbacks = HashMap<int, Function(Shape shape, Vector2 point, double distance, Vector2 gradient)>();
final _s_rectQuery_callbacks = HashMap<int, Function(Shape shape)>();
final _s_shapeQuery_callbacks = HashMap<int, Function(Shape shape, ContactPointSet points)>();
final _s_eachConstraint_callbacks = HashMap<int, Function(Constraint)>();

HashMap<int, void Function(Space, T)> addcllc<T>() {
  return HashMap<int, void Function(Space, T)>();
}

int __calbackIdGen(int a, String b) => a + __signatureGen(b);
int __signatureGen(String val) {
  int v = 1;
  return val.codeUnits.reduce((a, b) => (a + v++) + (b * v++));
}

final _sp_data = HashMap<int, dynamic>();
