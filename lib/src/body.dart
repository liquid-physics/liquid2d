// ignore_for_file: non_constant_identifier_names

part of 'liquid.dart';

class Body extends Liquid {
  late final BodyResources _body;
  Body({required double mass, required double moment}) : _body = BodyResources(bindings.cpBodyNew(mass, moment));
  Body._fromPointer(Pointer<cpBody> body) : _body = BodyResources(body);
  Pointer<cpBody> get _toPointer => _body.toPointer;

  /// Destroy a Body.
  void destroy() => _body.destroy();

  /// Set the position of the body.
  void setPosition({required Vector2 pos}) => _body.setPosition(pos: pos);

  /// Set the velocity of the body.
  void setVelocity({required Vector2 vel}) => _body.setVelocity(vel: vel);

  /// Set the position of a body.
  Vector2 getPosition() => _body.getPosition();

  /// Get the velocity of the body.
  Vector2 getVelocity() => _body.getVelocity();

  /// Convert body absolute/world coordinates to  relative/local coordinates.
  Vector2 worldToLocal(Vector2 point) => _body.worldToLocal(point);

  /// Convert body relative/local coordinates to absolute/world coordinates.
  Vector2 localToWorld(Vector2 point) => _body.localToWorld(point);

  /// Set the angular velocity of the body.
  void setAngularVelocity(double angularVelocity) => _body.setAngularVelocity(angularVelocity);

  /// Get the angle of the body.
  double getAngle() => _body.getAngle();

  /// Set the angle of a body.
  void setAngle(double a) => _body.setAngle(a);

  /// Get the mass of the body.
  double getMass() => _body.getMass();

  /// Set the type of the body.
  void setType(BodyType type) => _body.setType(type);

  /// Set the mass of the body.
  void setMass(double m) => _body.setMass(m);

  /// Set the moment of inertia of the body.
  void setMoment(double i) => _body.setMoment(i);

  /// Get the type of the body.
  BodyType getType() => _body.getType();

  Matrix4 get transform => _body.transform;
  Vector2 get p => _body.p;
  set p(Vector2 pos) => _body.p = pos;
  Vector2 get v => _body.v;
  set v(Vector2 pos) => _body.v = pos;

  /// Default velocity integration function..
  void updateVelocity({required Vector2 gravity, required double damping, required double dt}) => _body.updateVelocity(gravity: gravity, damping: damping, dt: dt);

  /// Set the callback used to update a body's velocity.
  void setVelocityUpdateFunc(void Function(Body body, Vector2 gravity, double damping, double dt) velocityFunc) => _body.setVelocityUpdateFunc(velocityFunc);

  /// Get the rotation vector of the body. (The x basis vector of it's transform.)
  Vector2 getRotation() => _body.getRotation();

  /// Call @c func once for each arbiter that is currently active on the body.
  void eachArbiter(void Function(Body body, Arbiter arbiter) arbiterFunc) => _body.eachArbiter(arbiterFunc);

  /// Apply an impulse to a body. Both the impulse and point are expressed in world coordinates.
  void applyImpulseAtWorldPoint({required Vector2 impulse, required Vector2 point}) => _body.applyImpulseAtWorldPoint(impulse: impulse, point: point);

  /// Get the velocity on a body (in world units) at a point on the body in world coordinates.
  Vector2 getVelocityAtWorldPoint({required Vector2 point}) => _body.getVelocityAtWorldPoint(point: point);

  /// Get the offset of the center of gravity in body local coordinates.
  Vector2 getCenterOfGravity() => _body.getCenterOfGravity();

  /// Get the angular velocity of the body.
  double getAngularVelocity() => _body.getAngularVelocity();

  /// Get the moment of inertia of the body.
  double getMoment() => _body.getMoment();

  bool get isExist => _body.isExist;

  /// Wake up a sleeping or idle body.
  void activate() => _body.activate();

  /// Wake up any sleeping or idle bodies touching a static body.
  void activateStatic(Shape filter) => _body.activateStatic(filter);

  /// Force a body to fall asleep immediately.
  void sleep() => _body.sleep();

  Sleeping get sleeping => _body.sleeping;

  /// Force a body to fall asleep immediately along with other bodies in a group.
  void sleepWithGroup(Body body) => _body.sleepWithGroup(body);

  /// Returns true if the body is sleeping.
  bool get isSleeping => _body.isSleeping;

  /// Get the space this body is added to.
  Space getSpace() => _body.getSpace();

  /// Set the offset of the center of gravity in body local coordinates.
  void setCenterOfGravity(Vector2 cog) => _body.setCenterOfGravity(cog);

  /// Get the force applied to the body for the next time step.
  Vector2 getForce() => _body.getForce();

  /// Set the force applied to the body for the next time step.
  void setForce(Vector2 force) => _body.setForce(force);

  /// Get the torque applied to the body for the next time step.
  double getTorque() => _body.getTorque();

  /// Set the torque applied to the body for the next time step.
  void setTorque(double torque) => _body.setTorque(torque);

  /// Default position integration function.
  void updatePosition(double dt) => _body.updatePosition(dt);

  /// Apply a force to a body. Both the force and point are expressed in world coordinates.
  void applyForceAtWorldPoint({required Vector2 force, required Vector2 point}) => _body.applyForceAtWorldPoint(force: force, point: point);

  /// Apply a force to a body. Both the force and point are expressed in body local coordinates.
  void applyForceAtLocalPoint({required Vector2 force, required Vector2 point}) => _body.applyForceAtLocalPoint(force: force, point: point);

  /// Apply an impulse to a body. Both the impulse and point are expressed in world coordinates.
  void applyImpulseAtLocalPoint({required Vector2 impulse, required Vector2 point}) => _body.applyImpulseAtLocalPoint(impulse: impulse, point: point);

  /// Get the velocity on a body (in world units) at a point on the body in local coordinates.
  Vector2 getVelocityAtLocalPoint(Vector2 point) => _body.getVelocityAtLocalPoint(point);

  /// Get the amount of kinetic energy contained by the body.
  double get kineticEnergy => _body.kineticEnergy;

  /// Set the callback used to update a body's position.
  /// NOTE: It's not generally recommended to override this unless you call the default position update function.
  void setPositionUpdateFunc(void Function(Body body, double dt) positionFunc) => _body.setPositionUpdateFunc(positionFunc);

  /// Call @c func once for each shape attached to @c body and added to the space.
  void eachShape(void Function(Body body, Shape shape) shapeFunc) => _body.eachShape(shapeFunc);

  /// Call @c func once for each constraint attached to @c body and added to the space.
  void eachConstraint(void Function(Body body, Constraint constraint) constraintFunc) => _body.eachConstraint(constraintFunc);

  /// Set the user data  assigned to the body.
  void setData<T>(T data) {
    _bd_data[_toPointer.address] = data;
  }

  /// Get the user data assigned to the body.
  T? getData<T>() {
    var q = _bd_data[_toPointer.address];
    if (q != null) {
      return q as T;
    } else {
      return null;
    }
  }

  /// Remove the user data assigned to the body.
  void removeData() {
    if (_bd_data.isNotEmpty) {
      _bd_data.remove(_toPointer.address);
    }
  }
}

class BodyResources {
  late Pointer<cpBody> _body;

  BodyResources(this._body);

  bool get isSleeping => bindings.cpBodyIsSleeping(_body) == 0 ? false : true;

  double get kineticEnergy => bindings.cpBodyKineticEnergy(_body);

  void destroy() {
    if (_body != nullptr) {
      bindings.cpBodyFree(_body);
      _body = nullptr;
      _b_setVelocityUpdateFunc_callbacks.removeWhere((key, value) => value.$1 == _body.address);
      _b_eachArbiter_callbacks.removeWhere((key, value) => value.$1 == _body.address);
      _b_eachShape_callbacks.removeWhere((key, value) => value.$1 == _body.address);
      _b_eachConstraint_callbacks.removeWhere((key, value) => value.$1 == _body.address);
      _b_setPositionUpdateFunc_callbacks.removeWhere((key, value) => value.$1 == _body.address);
    }
  }

  bool get isExist => _body != nullptr;

  Pointer<cpBody> get toPointer => _body;

  void setPosition({required Vector2 pos}) {
    bindings.cpBodySetPosition(_body, pos.toCpVect().ref);
  }

  void setVelocity({required Vector2 vel}) {
    bindings.cpBodySetVelocity(_body, vel.toCpVect().ref);
  }

  Vector2 getPosition() {
    return bindings.cpBodyGetPosition(_body).toVector2();
  }

  Vector2 getVelocity() {
    return bindings.cpBodyGetVelocity(_body).toVector2();
  }

  Vector2 getRotation() {
    return bindings.cpBodyGetRotation(_body).toVector2();
  }

  Vector2 worldToLocal(Vector2 point) {
    return bindings.cpBodyWorldToLocal(_body, point.toCpVect().ref).toVector2();
  }

  Vector2 localToWorld(Vector2 point) {
    return bindings.cpBodyLocalToWorld(_body, point.toCpVect().ref).toVector2();
  }

  void setAngularVelocity(double angularVelocity) {
    bindings.cpBodySetAngularVelocity(_body, angularVelocity);
  }

  double getAngularVelocity() => bindings.cpBodyGetAngularVelocity(_body);

  void applyImpulseAtWorldPoint({required Vector2 impulse, required Vector2 point}) => bindings.cpBodyApplyImpulseAtWorldPoint(_body, impulse.toCpVect().ref, point.toCpVect().ref);

  Vector2 getVelocityAtWorldPoint({required Vector2 point}) => bindings.cpBodyGetVelocityAtWorldPoint(_body, point.toCpVect().ref).toVector2();

  Vector2 getCenterOfGravity() => bindings.cpBodyGetCenterOfGravity(_body).toVector2();

  double getAngle() {
    return bindings.cpBodyGetAngle(_body);
  }

  double getMoment() => bindings.cpBodyGetMoment(_body);

  void setAngle(double a) {
    bindings.cpBodySetAngle(_body, a);
  }

  double getMass() {
    return bindings.cpBodyGetMass(_body);
  }

  void setType(BodyType type) {
    bindings.cpBodySetType(_body, type.toCpBodyType());
  }

  void setMass(double m) {
    bindings.cpBodySetMass(_body, m);
  }

  void setMoment(double i) {
    bindings.cpBodySetMoment(_body, i);
  }

  BodyType getType() {
    return bindings.cpBodyGetType(_body).toBodyType();
  }

  Matrix4 get transform => _body.ref.transform.toMatrix4();

  void updateVelocity({required Vector2 gravity, required double damping, required double dt}) {
    bindings.cpBodyUpdateVelocity(_body, gravity.toCpVect().ref, damping, dt, 0);
  }

  void setVelocityUpdateFunc(void Function(Body body, Vector2 gravity, double damping, double dt) velocityFunc) {
    var cId = __calbackIdGen(_body.address, 'setVelocityUpdateFunc');
    _b_setVelocityUpdateFunc_callbacks[cId] = (_body.address, velocityFunc);
    bindings.cpBodySetVelocityUpdateFunc(_body, Pointer.fromFunction(_b_setVelocityUpdateFuncCallback), cId);
  }

  void eachArbiter(void Function(Body body, Arbiter arbiter) arbiterFunc) {
    var cId = __calbackIdGen(_body.address, 'eachArbiter');
    _b_eachArbiter_callbacks[cId] = (_body.address, arbiterFunc);
    bindings.cpBodyEachArbiter(_body, Pointer.fromFunction(_b_eachArbiterCallback), nullptr, cId);
  }

  Vector2 get p => _body.ref.p.toVector2();
  set p(Vector2 pos) => _body.ref.p = pos.toCpVect().ref;

  Vector2 get v => _body.ref.v.toVector2();
  set v(Vector2 pos) => _body.ref.v = pos.toCpVect().ref;

  void activate() {
    bindings.cpBodyActivate(_body);
  }

  void activateStatic(Shape filter) {
    bindings.cpBodyActivateStatic(_body, filter._toPointer);
  }

  void sleep() {
    bindings.cpBodySleep(_body);
  }

  Sleeping get sleeping => _body.ref.sleeping.toSleeping();

  void sleepWithGroup(Body body) {
    bindings.cpBodySleepWithGroup(_body, body._toPointer);
  }

  Space getSpace() => Space._fromPointer(bindings.cpBodyGetSpace(_body));

  void setCenterOfGravity(Vector2 cog) {
    bindings.cpBodySetCenterOfGravity(_body, cog.toCpVect().ref);
  }

  Vector2 getForce() => bindings.cpBodyGetForce(_body).toVector2();

  void setForce(Vector2 force) => bindings.cpBodySetForce(_body, force.toCpVect().ref);

  double getTorque() => bindings.cpBodyGetTorque(_body);

  void setTorque(double torque) => bindings.cpBodySetTorque(_body, torque);

  void updatePosition(double dt) => bindings.cpBodyUpdatePosition(_body, dt, 0);

  void applyForceAtWorldPoint({required Vector2 force, required Vector2 point}) => bindings.cpBodyApplyForceAtWorldPoint(_body, force.toCpVect().ref, point.toCpVect().ref);

  void applyForceAtLocalPoint({required Vector2 force, required Vector2 point}) => bindings.cpBodyApplyForceAtLocalPoint(_body, force.toCpVect().ref, point.toCpVect().ref);

  void applyImpulseAtLocalPoint({required Vector2 impulse, required Vector2 point}) => bindings.cpBodyApplyImpulseAtLocalPoint(_body, impulse.toCpVect().ref, point.toCpVect().ref);

  Vector2 getVelocityAtLocalPoint(body) => bindings.cpBodyGetVelocityAtLocalPoint(_body, body).toVector2();

  void setPositionUpdateFunc(void Function(Body body, double dt) positionFunc) {
    var cId = __calbackIdGen(_body.address, 'setPositionUpdateFunc');
    _b_setPositionUpdateFunc_callbacks[cId] = (_body.address, positionFunc);
    bindings.cpBodySetPositionUpdateFunc(_body, Pointer.fromFunction(_b_setPositionUpdateFuncCallback), cId);
  }

  void eachShape(void Function(Body body, Shape shape) shapeFunc) {
    var cId = __calbackIdGen(_body.address, 'eachShape');
    _b_eachShape_callbacks[cId] = (_body.address, shapeFunc);
    bindings.cpBodyEachShape(_body, Pointer.fromFunction(_b_eachShapeCallback), nullptr, cId);
  }

  void eachConstraint(void Function(Body body, Constraint constraint) constraintFunc) {
    var cId = __calbackIdGen(_body.address, 'eachConstraint');
    _b_eachConstraint_callbacks[cId] = (_body.address, constraintFunc);
    bindings.cpBodyEachConstraint(_body, Pointer.fromFunction(_b_eachConstraintCallback), nullptr, cId);
  }
}

void _b_eachArbiterCallback(Pointer<cpBody> body, Pointer<cpArbiter> arbiter, Pointer<Void> data, int callbackId) {
  _b_eachArbiter_callbacks[callbackId]!.$2.call(Body._fromPointer(body), Arbiter._fromPointer(arbiter));
}

void _b_eachShapeCallback(Pointer<cpBody> body, Pointer<cpShape> shape, Pointer<Void> data, int callbackId) {
  _b_eachShape_callbacks[callbackId]!.$2.call(Body._fromPointer(body), Shape._createDartShape(shape));
}

void _b_eachConstraintCallback(Pointer<cpBody> body, Pointer<cpConstraint> constraint, Pointer<Void> data, int callbackId) {
  _b_eachConstraint_callbacks[callbackId]!.$2.call(Body._fromPointer(body), Constraint._createDartConstraint(constraint));
}

void _b_setVelocityUpdateFuncCallback(Pointer<cpBody> body, cpVect gravity, double damping, double dt, int callbackId) {
  _b_setVelocityUpdateFunc_callbacks[callbackId]!.$2.call(Body._fromPointer(body), gravity.toVector2(), damping, dt);
}

void _b_setPositionUpdateFuncCallback(Pointer<cpBody> body, double dt, int callbackId) {
  _b_setPositionUpdateFunc_callbacks[callbackId]!.$2.call(Body._fromPointer(body), dt);
}

/// Allocate and initialize a cpBody, and set it as a kinematic body.
class KinematicBody extends Body {
  KinematicBody() : super(mass: 0, moment: 0) {
    setType(BodyType.kinematic);
  }
}

/// Allocate and initialize a cpBody, and set it as a static body.
class StaticBody extends Body {
  StaticBody() : super(mass: 0, moment: 0) {
    setType(BodyType.static);
  }
}

var _b_setVelocityUpdateFunc_callbacks = HashMap<int, (int, Function(Body, Vector2, double, double))>();
var _b_setPositionUpdateFunc_callbacks = HashMap<int, (int, Function(Body, double))>();
var _b_eachArbiter_callbacks = HashMap<int, (int, Function(Body, Arbiter))>();
var _b_eachShape_callbacks = HashMap<int, (int, Function(Body, Shape))>();
var _b_eachConstraint_callbacks = HashMap<int, (int, Function(Body, Constraint))>();
final _bd_data = HashMap<int, dynamic>();

enum BodyType {
  /// A dynamic body is one that is affected by gravity, forces, and collisions.
  /// This is the default body type.
  dynamic,

  /// A kinematic body is an infinite mass, user controlled body that is not affected by gravity, forces or collisions.
  /// Instead the body only moves based on it's velocity.
  /// Dynamic bodies collide normally with kinematic bodies, though the kinematic body will be unaffected.
  /// Collisions between two kinematic bodies, or a kinematic body and a static body produce collision callbacks, but no collision response.
  kinematic,

  /// A static body is a body that never (or rarely) moves. If you move a static body, you must call one of the cpSpaceReindex*() functions.
  /// Chipmunk uses this information to optimize the collision detection.
  /// Static bodies do not produce collision callbacks when colliding with other static bodies.
  static
}
