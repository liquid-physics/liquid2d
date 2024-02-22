// ignore_for_file: non_constant_identifier_names

part of 'liquid2d.dart';

class Constraint extends liquid2d {
  late final ConstraintResource _constraint;
  Constraint._fromPointer(Pointer<cpConstraint> constraint) : _constraint = ConstraintResource(constraint);
  Pointer<cpConstraint> get _toPointer => _constraint.toPointer;

  double get maxForce => _constraint.maxForce;
  set maxForce(double value) => _constraint.maxForce = value;
  double get errorBias => _constraint.errorBias;
  set errorBias(double value) => _constraint.errorBias = value;
  bool get isExist => _constraint.isExist;

  Body get a => _constraint.a;
  Body get b => _constraint.b;

  /// Destroy a constraint.
  void destroy() => _constraint.destroy();

  /// Set the maximum force that this constraint is allowed to use. (defaults to INFINITY)
  void setMaxForce(double force) => _constraint.setMaxForce(force);

  /// Set the maximum rate at which joint error is corrected. (defaults to INFINITY)
  void setMaxBias(double maxBias) => _constraint.setMaxBias(maxBias);

  /// Set rate at which joint error is corrected.
  /// Defaults to pow(1.0 - 0.1, 60.0) meaning that it will
  /// correct 10% of the error every 1/60th of a second.
  void setErrorBias(double errorBias) => _constraint.setErrorBias(errorBias);

  /// Set if the two bodies connected by the constraint are allowed to collide or not. (defaults to cpFalse)
  void setCollideBody(bool collideBodies) => _constraint.setCollideBody(collideBodies);

  /// Set the post-solve function that is called before the solver runs.
  void setPostSolveFunc(void Function(Constraint constraint, Space space) postSolveFunc) => _constraint.setPostSolveFunc(postSolveFunc);

  /// Set the pre-solve function that is called before the solver runs.
  void setPreSolveFunc(void Function(Constraint constraint, Space space) preSolveFunc) => _constraint.setPreSolveFunc(preSolveFunc);

  /// Get the last impulse applied by this constraint.
  double getImpulse() => _constraint.getImpulse();

  /// Get the maximum force that this constraint is allowed to use.
  double getMaxForce() => _constraint.getMaxForce();

  /// Get the cpSpace this constraint is added to.
  Space getSpace() => _constraint.getSpace();

  /// Get the first body the constraint is attached to.
  Body getBodyA() => _constraint.getBodyA();

  /// Get the second body the constraint is attached to.
  Body getBodyB() => _constraint.getBodyB();

  /// Get rate at which joint error is corrected.
  double getErrorBias() => _constraint.getErrorBias();

  /// Get the maximum rate at which joint error is corrected.
  double getMaxBias() => _constraint.getMaxBias();

  /// Get if the two bodies connected by the constraint are allowed to collide or not.
  bool getCollideBodies() => _constraint.getCollideBodies();

  /// Set if the two bodies connected by the constraint are allowed to collide or not. (defaults to cpFalse)
  void setCollideBodies(bool collideBodies) => _constraint.setCollideBodies(collideBodies);

  /// Set the user data  assigned to the constraint.
  void setData<T>(T data) {
    _cr_data[_toPointer.address] = data;
  }

  /// Get the user data assigned to the constraint.
  T? getData<T>() {
    var q = _cr_data[_toPointer.address];
    if (q != null) {
      return q as T;
    } else {
      return null;
    }
  }

  /// Remove the user data assigned to the constraint.
  void removeData() {
    if (_cr_data.isNotEmpty) {
      _cr_data.remove(_toPointer.address);
    }
  }

  static Constraint _createDartConstraint(Pointer<cpConstraint> constraint) => ConstraintResource._createDartConstraint(constraint);
}

class ConstraintResource {
  late Pointer<cpConstraint> _constraint;
  ConstraintResource(this._constraint);
  void destroy() {
    if (_constraint != nullptr) {
      bindings.cpConstraintFree(_constraint);
      _constraint = nullptr;
      _cr_setPostSolveFunc_callbacks.removeWhere((key, value) => value.$1 == _constraint.address);
      _cr_setPreSolveFunc_callbacks.removeWhere((key, value) => value.$1 == _constraint.address);
      _ds_setSpringForceFunc_callbacks.removeWhere((key, value) => value.$1 == _constraint.address);
    }
  }

  Pointer<cpConstraint> get toPointer => _constraint;
  double get maxForce => _constraint.ref.maxForce;
  set maxForce(double value) => _constraint.ref.maxForce = value;
  double get errorBias => _constraint.ref.errorBias;
  set errorBias(double value) => _constraint.ref.errorBias = value;
  bool get isExist => _constraint != nullptr;
  bool get isDampedSpring => bindings.cpConstraintIsDampedSpring(_constraint) == 1 ? true : false;
  bool get isSimpleMotor => bindings.cpConstraintIsSimpleMotor(_constraint) == 1 ? true : false;
  bool get isPivotJoint => bindings.cpConstraintIsPivotJoint(_constraint) == 1 ? true : false;
  bool get isPinJoint => bindings.cpConstraintIsPinJoint(_constraint) == 1 ? true : false;
  bool get isGearJoint => bindings.cpConstraintIsGearJoint(_constraint) == 1 ? true : false;
  bool get isDampedRotarySpring => bindings.cpConstraintIsDampedRotarySpring(_constraint) == 1 ? true : false;
  bool get isGrooveJoint => bindings.cpConstraintIsGrooveJoint(_constraint) == 1 ? true : false;
  bool get isRatchetJoint => bindings.cpConstraintIsRatchetJoint(_constraint) == 1 ? true : false;
  bool get isRotaryLimitJoint => bindings.cpConstraintIsRotaryLimitJoint(_constraint) == 1 ? true : false;
  bool get isSlideJoint => bindings.cpConstraintIsSlideJoint(_constraint) == 1 ? true : false;
  Body get a => Body._fromPointer(_constraint.ref.a);
  Body get b => Body._fromPointer(_constraint.ref.b);
  void setMaxForce(double force) {
    bindings.cpConstraintSetMaxForce(_constraint, force);
  }

  double getImpulse() => bindings.cpConstraintGetImpulse(_constraint);
  double getMaxForce() => bindings.cpConstraintGetMaxForce(_constraint);
  void setCollideBody(bool collideBodies) => bindings.cpConstraintSetCollideBodies(_constraint, collideBodies ? 1 : 0);
  void setMaxBias(double maxBias) => bindings.cpConstraintSetMaxBias(_constraint, maxBias);
  void setErrorBias(double errorBias) => bindings.cpConstraintSetErrorBias(_constraint, errorBias);

  void setPostSolveFunc(void Function(Constraint constraint, Space space) postSolveFunc) {
    var cId = __calbackIdGen(_constraint.address, 'setPostSolveFunc');
    _cr_setPostSolveFunc_callbacks[cId] = (_constraint.address, postSolveFunc);
    bindings.cpConstraintSetPostSolveFunc(_constraint, Pointer.fromFunction(cr_postSolveCallback), cId);
  }

  void setPreSolveFunc(void Function(Constraint constraint, Space space) preSolveFunc) {
    var cId = __calbackIdGen(_constraint.address, 'setPreSolveFunc');
    _cr_setPreSolveFunc_callbacks[cId] = (_constraint.address, preSolveFunc);
    bindings.cpConstraintSetPostSolveFunc(_constraint, Pointer.fromFunction(cr_preSolveCallback), cId);
  }

  static Constraint _createDartConstraint(Pointer<cpConstraint> constraint) {
    if (bindings.cpConstraintIsDampedSpring(constraint) == 1) {
      return DampedSpring._fromPointer(constraint);
    } else if (bindings.cpConstraintIsPivotJoint(constraint) == 1) {
      return PivotJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsPinJoint(constraint) == 1) {
      return PinJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsSimpleMotor(constraint) == 1) {
      return SimpleMotor._fromPointer(constraint);
    } else if (bindings.cpConstraintIsGearJoint(constraint) == 1) {
      return GearJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsDampedRotarySpring(constraint) == 1) {
      return DampedRotarySpring._fromPointer(constraint);
    } else if (bindings.cpConstraintIsGrooveJoint(constraint) == 1) {
      return GrooveJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsRatchetJoint(constraint) == 1) {
      return RatchetJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsRotaryLimitJoint(constraint) == 1) {
      return RotaryLimitJoint._fromPointer(constraint);
    } else if (bindings.cpConstraintIsSlideJoint(constraint) == 1) {
      return SlideJoint._fromPointer(constraint);
    } else {
      throw 'Constraint not found';
    }
  }

  Space getSpace() => Space._fromPointer(bindings.cpConstraintGetSpace(_constraint));

  Body getBodyA() => Body._fromPointer(bindings.cpConstraintGetBodyA(_constraint));

  Body getBodyB() => Body._fromPointer(bindings.cpConstraintGetBodyB(_constraint));

  double getErrorBias() => bindings.cpConstraintGetErrorBias(_constraint);

  double getMaxBias() => bindings.cpConstraintGetMaxBias(_constraint);

  bool getCollideBodies() => bindings.cpConstraintGetCollideBodies(_constraint) == 0 ? false : true;

  void setCollideBodies(bool collideBodies) => bindings.cpConstraintSetCollideBodies(_constraint, collideBodies ? 1 : 0);
}

void cr_postSolveCallback(Pointer<cpConstraint> constraint, Pointer<cpSpace> space, int callbackId) {
  _cr_setPostSolveFunc_callbacks[callbackId]!.$2.call(
        Constraint._createDartConstraint(constraint),
        Space._fromPointer(space),
      );
}

void cr_preSolveCallback(Pointer<cpConstraint> constraint, Pointer<cpSpace> space, int callbackId) {
  _cr_setPreSolveFunc_callbacks[callbackId]!.$2.call(
        Constraint._createDartConstraint(constraint),
        Space._fromPointer(space),
      );
}

/// Pivot Joint Constraint
class PivotJoint extends Constraint {
  PivotJoint({required Body a, required Body b, required Vector2 anchorA, required Vector2 anchorB})
      : super._fromPointer(bindings.cpPivotJointNew2(a._toPointer, b._toPointer, anchorA.toCpVect().ref, anchorB.toCpVect().ref));

  PivotJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Set the location of the first anchor relative to the first body.
  void setAnchorA(Vector2 anchorA) => bindings.cpPivotJointSetAnchorA(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the first anchor relative to the first body.
  Vector2 getAnchorA() => bindings.cpPivotJointGetAnchorA(_constraint.toPointer).toVector2();

  /// Set the location of the second anchor relative to the second body.
  void setAnchorB(Vector2 anchorA) => bindings.cpPivotJointSetAnchorB(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the second anchor relative to the second body.
  Vector2 getAnchorB() => bindings.cpPivotJointGetAnchorB(_constraint.toPointer).toVector2();
}

/// Pin Joint Constraint
class PinJoint extends Constraint {
  PinJoint({required Body a, required Body b, required Vector2 anchorA, required Vector2 anchorB})
      : super._fromPointer(bindings.cpPinJointNew(a._toPointer, b._toPointer, anchorA.toCpVect().ref, anchorB.toCpVect().ref));
  PinJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Set the distance the joint will maintain between the two anchors.
  void setDist(double dist) => bindings.cpPinJointSetDist(_constraint.toPointer, dist);

  /// Get the distance the joint will maintain between the two anchors.
  double getDist() => bindings.cpPinJointGetDist(_constraint.toPointer);

  /// Set the location of the first anchor relative to the first body.
  void setAnchorA(Vector2 anchorA) => bindings.cpPinJointSetAnchorA(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the first anchor relative to the first body.
  Vector2 getAnchorA() => bindings.cpPinJointGetAnchorA(_constraint.toPointer).toVector2();

  /// Set the location of the second anchor relative to the second body.
  void setAnchorB(Vector2 anchorA) => bindings.cpPinJointSetAnchorB(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the second anchor relative to the second body.
  Vector2 getAnchorB() => bindings.cpPinJointGetAnchorB(_constraint.toPointer).toVector2();
}

/// Simple Motor Constraint
class SimpleMotor extends Constraint {
  SimpleMotor({required Body a, required Body b, required double rate}) : super._fromPointer(bindings.cpSimpleMotorNew(a._toPointer, b._toPointer, rate));

  /// Set the rate of the motor.
  void setRate(double rate) => bindings.cpSimpleMotorSetRate(_constraint.toPointer, rate);

  /// Get the rate of the motor.
  double getRate() => bindings.cpSimpleMotorGetRate(_constraint.toPointer);
  SimpleMotor._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);
}

class GearJoint extends Constraint {
  GearJoint({required Body a, required Body b, required double phase, required double ratio}) : super._fromPointer(bindings.cpGearJointNew(a._toPointer, b._toPointer, phase, ratio));
  GearJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the phase offset of the gears.
  double getPhase() => bindings.cpGearJointGetPhase(_constraint.toPointer);

  /// Set the ratio of a gear joint.
  void setPhase(double phase) => bindings.cpGearJointSetPhase(_constraint.toPointer, phase);

  /// Get the angular distance of each ratchet.
  double getRatio() => bindings.cpGearJointGetRatio(_constraint.toPointer);

  /// Set the ratio of a gear joint.
  void setRatio(double ratio) => bindings.cpGearJointSetRatio(_constraint.toPointer, ratio);
}

class DampedRotarySpring extends Constraint {
  DampedRotarySpring({
    required Body a,
    required Body b,
    required double restAngle,
    required double stiffness,
    required double damping,
  }) : super._fromPointer(bindings.cpDampedRotarySpringNew(a._toPointer, b._toPointer, restAngle, stiffness, damping));
  DampedRotarySpring._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the rest length of the spring.
  double getRestAngle() => bindings.cpDampedRotarySpringGetRestAngle(_constraint.toPointer);

  /// Set the rest length of the spring.
  void setRestAngle(double restAngle) => bindings.cpDampedRotarySpringSetRestAngle(_constraint.toPointer, restAngle);

  /// Get the stiffness of the spring in force/distance.
  double getStiffness() => bindings.cpDampedRotarySpringGetStiffness(_constraint.toPointer);

  /// Set the stiffness of the spring in force/distance.
  void setStiffness(double stiffness) => bindings.cpDampedRotarySpringSetStiffness(_constraint.toPointer, stiffness);

  /// Get the damping of the spring.
  double getDamping() => bindings.cpDampedRotarySpringGetDamping(_constraint.toPointer);

  /// Set the damping of the spring.
  void setDamping(double stiffness) => bindings.cpDampedRotarySpringSetDamping(_constraint.toPointer, stiffness);

  /// Set the damping of the spring.
  void setSpringTorqueFunc(double Function(DampedRotarySpring constraint, double relativeAngle) springTorqueFunc) {
    var cId = __calbackIdGen(_constraint.toPointer.address, 'setSpringTorqueFunc');
    _drs_setSpringTorqueFunc_callbacks[cId] = (_constraint.toPointer.address, springTorqueFunc);
    bindings.cpDampedRotarySpringSetSpringTorqueFunc(_constraint.toPointer, Pointer.fromFunction(_drs_springTorqueCallback, 0.0), cId);
  }

  @override
  void destroy() {
    _drs_setSpringTorqueFunc_callbacks.clear;
    super.destroy();
  }
}

class GrooveJoint extends Constraint {
  GrooveJoint({
    required Body a,
    required Body b,
    required Vector2 grooveA,
    required Vector2 grooveB,
    required Vector2 anchorB,
  }) : super._fromPointer(bindings.cpGrooveJointNew(a._toPointer, b._toPointer, grooveA.toCpVect().ref, grooveB.toCpVect().ref, anchorB.toCpVect().ref));
  GrooveJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the first endpoint of the groove relative to the first body.
  Vector2 getGrooveA() => bindings.cpGrooveJointGetGrooveA(_constraint.toPointer).toVector2();

  /// Set the first endpoint of the groove relative to the first body.
  void setGrooveA(Vector2 grooveA) => bindings.cpGrooveJointSetGrooveA(_constraint.toPointer, grooveA.toCpVect().ref);

  /// Get the first endpoint of the groove relative to the first body.
  Vector2 getGrooveB() => bindings.cpGrooveJointGetGrooveB(_constraint.toPointer).toVector2();

  /// Set the first endpoint of the groove relative to the first body.
  void setGrooveB(Vector2 grooveB) => bindings.cpGrooveJointSetGrooveB(_constraint.toPointer, grooveB.toCpVect().ref);

  /// Set the location of the second anchor relative to the second body.
  void setAnchorB(Vector2 anchorA) => bindings.cpGrooveJointSetAnchorB(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the second anchor relative to the second body.
  Vector2 getAnchorB() => bindings.cpGrooveJointGetAnchorB(_constraint.toPointer).toVector2();
}

class RatchetJoint extends Constraint {
  RatchetJoint({
    required Body a,
    required Body b,
    required double phase,
    required double ratchet,
  }) : super._fromPointer(bindings.cpRatchetJointNew(a._toPointer, b._toPointer, phase, ratchet));
  RatchetJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the angle of the current ratchet tooth.
  double getAngle() => bindings.cpRatchetJointGetAngle(_constraint.toPointer);

  /// Set the angle of the current ratchet tooth.
  void setAngle(double angle) => bindings.cpRatchetJointSetAngle(_constraint.toPointer, angle);

  /// Get the angular distance of each ratchet.
  double getRatchet() => bindings.cpRatchetJointGetRatchet(_constraint.toPointer);

  /// Set the angular distance of each ratchet.
  void setRatchet(double ratchet) => bindings.cpRatchetJointSetRatchet(_constraint.toPointer, ratchet);

  /// Get the phase offset of the ratchet.
  double getPhase() => bindings.cpRatchetJointGetPhase(_constraint.toPointer);

  /// Get the phase offset of the ratchet.
  void setPhase(double phase) => bindings.cpRatchetJointSetPhase(_constraint.toPointer, phase);
}

class RotaryLimitJoint extends Constraint {
  RotaryLimitJoint({
    required Body a,
    required Body b,
    required double min,
    required double max,
  }) : super._fromPointer(bindings.cpRotaryLimitJointNew(a._toPointer, b._toPointer, min, max));
  RotaryLimitJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the minimum distance the joint will maintain between the two anchors.
  double getMin() => bindings.cpRotaryLimitJointGetMin(_constraint.toPointer);

  /// Set the minimum distance the joint will maintain between the two anchors.
  void setMin(double min) => bindings.cpRotaryLimitJointSetMin(_constraint.toPointer, min);

  /// Get the maximum distance the joint will maintain between the two anchors.
  double getMax() => bindings.cpRotaryLimitJointGetMax(_constraint.toPointer);

  /// Set the maximum distance the joint will maintain between the two anchors.
  void setMax(double max) => bindings.cpRotaryLimitJointSetMax(_constraint.toPointer, max);
}

class SlideJoint extends Constraint {
  SlideJoint({
    required Body a,
    required Body b,
    required Vector2 anchorA,
    required Vector2 anchorB,
    required double min,
    required double max,
  }) : super._fromPointer(bindings.cpSlideJointNew(a._toPointer, b._toPointer, anchorA.toCpVect().ref, anchorB.toCpVect().ref, min, max));
  SlideJoint._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Get the minimum distance the joint will maintain between the two anchors.
  double getMin() => bindings.cpSlideJointGetMin(_constraint.toPointer);

  /// Set the minimum distance the joint will maintain between the two anchors.
  void setMin(double min) => bindings.cpSlideJointSetMin(_constraint.toPointer, min);

  /// Get the maximum distance the joint will maintain between the two anchors.
  double getMax() => bindings.cpSlideJointGetMax(_constraint.toPointer);

  /// Set the maximum distance the joint will maintain between the two anchors.
  void setMax(double max) => bindings.cpSlideJointSetMax(_constraint.toPointer, max);

  /// Set the location of the first anchor relative to the first body.
  void setAnchorA(Vector2 anchorA) => bindings.cpSlideJointSetAnchorA(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the first anchor relative to the first body.
  Vector2 getAnchorA() => bindings.cpSlideJointGetAnchorA(_constraint.toPointer).toVector2();

  /// Set the location of the second anchor relative to the second body.
  void setAnchorB(Vector2 anchorA) => bindings.cpSlideJointSetAnchorB(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the second anchor relative to the second body.
  Vector2 getAnchorB() => bindings.cpSlideJointGetAnchorB(_constraint.toPointer).toVector2();
}

class DampedSpring extends Constraint {
  DampedSpring({
    required Body a,
    required Body b,
    required Vector2 anchorA,
    required Vector2 anchorB,
    required double restLength,
    required double stiffness,
    required double damping,
  }) : super._fromPointer(bindings.cpDampedSpringNew(a._toPointer, b._toPointer, anchorA.toCpVect().ref, anchorB.toCpVect().ref, restLength, stiffness, damping));

  DampedSpring._fromPointer(Pointer<cpConstraint> constraint) : super._fromPointer(constraint);

  /// Set the damping of the spring.
  void setSpringForceFunc(double Function(DampedSpring constraint, double dist) springForceFunc) {
    var cId = __calbackIdGen(_constraint.toPointer.address, 'setSpringForceFunc');
    _ds_setSpringForceFunc_callbacks[cId] = (_constraint.toPointer.address, springForceFunc);
    bindings.cpDampedSpringSetSpringForceFunc(_constraint.toPointer, Pointer.fromFunction(_ds_springForceCallback, 0.0), cId);
  }

  /// Get the rest length of the spring.
  double getRestLength() => bindings.cpDampedSpringGetRestLength(_constraint.toPointer);

  /// Set the rest length of the spring.
  void setRestLength(double restLength) => bindings.cpDampedSpringSetRestLength(_constraint.toPointer, restLength);

  /// Get the stiffness of the spring in force/distance.
  double getStiffness() => bindings.cpDampedSpringGetStiffness(_constraint.toPointer);

  /// Set the stiffness of the spring in force/distance.
  void setStiffness(double stiffness) => bindings.cpDampedSpringSetStiffness(_constraint.toPointer, stiffness);

  /// Get the damping of the spring.
  double getDamping() => bindings.cpDampedSpringGetDamping(_constraint.toPointer);

  /// Set the damping of the spring.
  void setDamping(double damping) => bindings.cpDampedSpringSetDamping(_constraint.toPointer, damping);

  /// Set the location of the first anchor relative to the first body.
  void setAnchorA(Vector2 anchorA) => bindings.cpDampedSpringSetAnchorA(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the first anchor relative to the first body.
  Vector2 getAnchorA() => bindings.cpDampedSpringGetAnchorA(_constraint.toPointer).toVector2();

  /// Set the location of the second anchor relative to the second body.
  void setAnchorB(Vector2 anchorA) => bindings.cpDampedSpringSetAnchorB(_constraint.toPointer, anchorA.toCpVect().ref);

  /// Get the location of the second anchor relative to the second body.
  Vector2 getAnchorB() => bindings.cpDampedSpringGetAnchorB(_constraint.toPointer).toVector2();

  @override
  void destroy() {
    _ds_setSpringForceFunc_callbacks.clear;
    super.destroy();
  }
}

double _ds_springForceCallback(Pointer<cpConstraint> constraint, double dist, int callbackId) {
  return _ds_setSpringForceFunc_callbacks[callbackId]!.$2.call(
        DampedSpring._fromPointer(constraint),
        dist,
      );
}

double _drs_springTorqueCallback(Pointer<cpConstraint> constraint, double relativeAngle, int callbackId) {
  return _drs_setSpringTorqueFunc_callbacks[callbackId]!.$2.call(
        DampedRotarySpring._fromPointer(constraint),
        relativeAngle,
      );
}

var _ds_setSpringForceFunc_callbacks = HashMap<int, (int, double Function(DampedSpring constraint, double dist))>();
var _drs_setSpringTorqueFunc_callbacks = HashMap<int, (int, double Function(DampedRotarySpring constraint, double relativeAngle))>();
var _cr_setPostSolveFunc_callbacks = HashMap<int, (int, void Function(Constraint constraint, Space space))>();
var _cr_setPreSolveFunc_callbacks = HashMap<int, (int, void Function(Constraint constraint, Space space))>();
final _cr_data = HashMap<int, dynamic>();
