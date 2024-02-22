// ignore_for_file: non_constant_identifier_names

part of 'liquid2d.dart';

/// The cpArbiter struct tracks pairs of colliding shapes.
///
/// They are also used in conjuction with collision handler callbacks
/// allowing you to retrieve information on the collision or change it.
/// A unique arbiter value is used for each pair of colliding objects. It persists until the shapes separate.
class Arbiter {
  late final ArbiterResource _arbiterResource;
  Arbiter._fromPointer(Pointer<cpArbiter> arbiter) : _arbiterResource = ArbiterResource(arbiter);
  Pointer<cpArbiter> get _toPointer => _arbiterResource.toPointer;

  /// Return the colliding shapes involved for this arbiter.
  ///
  /// The order of their cpSpace.collision_type values will match
  /// the order set when the collision handler was registered.
  (Shape a, Shape b) getShapes() => _arbiterResource.getShapes();

  /// Return the colliding bodies involved for this arbiter.
  ///
  /// The order of the cpSpace.collision_type the bodies are associated with values will match
  /// the order set when the collision handler was registered.
  (Body a, Body b) getBodies() => _arbiterResource.getBodies();

  /// Get the normal of the collision.
  Vector2 getNormal() => _arbiterResource.getNormal();

  /// Calculate the total impulse including the friction that was applied by this arbiter.
  /// This function should only be called from a post-solve, post-step or cpBodyEachArbiter callback.
  Vector2 totalImpulse() => _arbiterResource.totalImpulse();

  /// Mark a collision pair to be ignored until the two objects separate.
  /// Pre-solve and post-solve callbacks will not be called, but the separate callback will be called.
  bool ignore() => _arbiterResource.ignore();

  /// Return a contact set from an arbiter.
  ContactPointSet getContactPointSet() => _arbiterResource.getContactPointSet();

  /// Replace the contact point set for an arbiter.
  /// This can be a very powerful feature, but use it with caution!
  void setContactPointSet(ContactPointSet contactPointSet) => _arbiterResource.setContactPointSet(contactPointSet);

  /// Get the restitution (elasticity) that will be applied to the pair of colliding objects.
  double getRestitution() => _arbiterResource.getRestitution();

  /// Override the restitution (elasticity) that will be applied to the pair of colliding objects.
  void setRestitution(double restitution) => _arbiterResource.setRestitution(restitution);

  /// Get the friction coefficient that will be applied to the pair of colliding objects.
  double getFriction() => _arbiterResource.getFriction();

  /// Override the friction coefficient that will be applied to the pair of colliding objects.
  void setFriction(double friction) => _arbiterResource.setFriction(friction);

  /// Get the relative surface velocity of the two shapes in contact.
  Vector2 getSurfaceVelocity() => _arbiterResource.getSurfaceVelocity();

  /// Override the relative surface velocity of the two shapes in contact.
  /// By default this is calculated to be the difference of the two surface velocities clamped to the tangent plane.
  void setSurfaceVelocity(Vector2 vr) => _arbiterResource.setSurfaceVelocity(vr);

  /// Calculate the amount of energy lost in a collision including static, but not dynamic friction.
  /// This function should only be called from a post-solve, post-step or cpBodyEachArbiter callback.
  double totalKE() => _arbiterResource.totalKE();

  /// Returns true if this is the first step a pair of objects started colliding.
  bool get isFirstContact => _arbiterResource.isFirstContact;

  /// Returns true if the separate callback is due to a shape being removed from the space.
  bool get isRemoval => _arbiterResource.isRemoval;

  /// Get the number of contact points for this arbiter.
  int getCount() => _arbiterResource.getCount();

  /// Get the position of the @c ith contact point on the surface of the first shape.
  Vector2 getPointA(int i) => _arbiterResource.getPointA(i);

  /// Get the position of the @c ith contact point on the surface of the second shape.
  Vector2 getPointB(int i) => _arbiterResource.getPointB(i);

  /// Get the depth of the @c ith contact point.
  double getDepth(int i) => _arbiterResource.getDepth(i);

  /// If you want a custom callback to invoke the wildcard callback for the first collision type, you must call this function explicitly.
  /// You must decide how to handle the wildcard's return value since it may disagree with the other wildcard handler's return value or your own.
  bool callWildcardBeginA(Space space) => _arbiterResource.callWildcardBeginA(space);

  /// If you want a custom callback to invoke the wildcard callback for the second collision type, you must call this function explicitly.
  /// You must decide how to handle the wildcard's return value since it may disagree with the other wildcard handler's return value or your own.
  bool callWildcardBeginB(Space space) => _arbiterResource.callWildcardBeginB(space);

  /// If you want a custom callback to invoke the wildcard callback for the first collision type, you must call this function explicitly.
  /// You must decide how to handle the wildcard's return value since it may disagree with the other wildcard handler's return value or your own.
  bool callWildcardPreSolveA(Space space) => _arbiterResource.callWildcardPreSolveA(space);

  /// If you want a custom callback to invoke the wildcard callback for the second collision type, you must call this function explicitly.
  /// You must decide how to handle the wildcard's return value since it may disagree with the other wildcard handler's return value or your own.
  bool callWildcardPreSolveB(Space space) => _arbiterResource.callWildcardPreSolveB(space);

  /// If you want a custom callback to invoke the wildcard callback for the first collision type, you must call this function explicitly.
  void callWildcardPostSolveA(Space space) => _arbiterResource.callWildcardPostSolveA(space);

  /// If you want a custom callback to invoke the wildcard callback for the second collision type, you must call this function explicitly.
  void callWildcardPostSolveB(Space space) => _arbiterResource.callWildcardPostSolveB(space);

  /// If you want a custom callback to invoke the wildcard callback for the first collision type, you must call this function explicitly.
  void callWildcardSeparateA(Space space) => _arbiterResource.callWildcardSeparateA(space);

  /// If you want a custom callback to invoke the wildcard callback for the second collision type, you must call this function explicitly.
  void callWildcardSeparateB(Space space) => _arbiterResource.callWildcardSeparateB(space);

  @override
  bool operator ==(other) {
    return _toPointer == (other as Arbiter)._toPointer;
  }

  @override
  int get hashCode => _toPointer.hashCode;

  /// Set a user data point associated with this pair of colliding objects.
  void setData<T>(T data) {
    _ar_data[_toPointer.address] = data;
  }

  /// Get the user data pointer associated with this pair of colliding objects.
  T? getData<T>() {
    var q = _ar_data[_toPointer.address];
    if (q != null) {
      return q as T;
    } else {
      return null;
    }
  }

  /// If you need to perform any cleanup for this data, you must do it yourself, in the separate callback for instance.
  void removeData() {
    if (_ar_data.isNotEmpty) {
      _ar_data.remove(_toPointer.address);
    }
  }
}

class ArbiterResource {
  late final Pointer<cpArbiter> _arbiterResource;
  ArbiterResource(this._arbiterResource);
  Pointer<cpArbiter> get toPointer => _arbiterResource;

  bool get isFirstContact => bindings.cpArbiterIsFirstContact(_arbiterResource) == 0 ? false : true;

  bool get isRemoval => bindings.cpArbiterIsRemoval(_arbiterResource) == 0 ? false : true;

  (Shape a, Shape b) getShapes() {
    Pointer<Pointer<cpShape>> aShape = calloc();
    Pointer<Pointer<cpShape>> bShape = calloc();
    bindings.cpArbiterGetShapes(_arbiterResource, aShape, bShape);
    var res = (Shape._createDartShape(aShape.value), Shape._createDartShape(bShape.value));
    calloc.free(aShape);
    calloc.free(bShape);
    return res;
  }

  (Body a, Body b) getBodies() {
    Pointer<Pointer<cpBody>> aBody = calloc();
    Pointer<Pointer<cpBody>> bBody = calloc();
    bindings.cpArbiterGetBodies(_arbiterResource, aBody, bBody);
    var res = (Body._fromPointer(aBody.value), Body._fromPointer(bBody.value));
    calloc.free(aBody);
    calloc.free(bBody);
    return res;
  }

  ContactPointSet getContactPointSet() {
    return ContactPointSet._fromPointer(bindings.cpArbiterGetContactPointSet(_arbiterResource));
  }

  int getCount() => bindings.cpArbiterGetCount(_arbiterResource);

  Vector2 totalImpulse() {
    return bindings.cpArbiterTotalImpulse(_arbiterResource).toVector2();
  }

  Vector2 getNormal() {
    return bindings.cpArbiterGetNormal(_arbiterResource).toVector2();
  }

  bool ignore() => bindings.cpArbiterIgnore(_arbiterResource) == 0 ? false : true;

  void setContactPointSet(ContactPointSet contactPointSet) {
    bindings.cpArbiterSetContactPointSet(_arbiterResource, contactPointSet.toCpContactPointSet());
  }

  double getRestitution() => bindings.cpArbiterGetRestitution(_arbiterResource);
  void setRestitution(double restitution) => bindings.cpArbiterSetRestitution(_arbiterResource, restitution);

  double getFriction() => bindings.cpArbiterGetFriction(_arbiterResource);

  void setFriction(double friction) {
    bindings.cpArbiterSetFriction(_arbiterResource, friction);
  }

  Vector2 getSurfaceVelocity() => bindings.cpArbiterGetSurfaceVelocity(_arbiterResource).toVector2();

  void setSurfaceVelocity(Vector2 vr) {
    bindings.cpArbiterSetSurfaceVelocity(_arbiterResource, vr.toCpVect().ref);
  }

  double totalKE() => bindings.cpArbiterTotalKE(_arbiterResource);

  Vector2 getPointA(int i) => bindings.cpArbiterGetPointA(_arbiterResource, i).toVector2();

  Vector2 getPointB(int i) => bindings.cpArbiterGetPointB(_arbiterResource, i).toVector2();

  double getDepth(int i) => bindings.cpArbiterGetDepth(_arbiterResource, i);

  bool callWildcardBeginA(Space space) {
    return bindings.cpArbiterCallWildcardBeginA(_arbiterResource, space._toPointer) == 0 ? false : true;
  }

  bool callWildcardBeginB(Space space) {
    return bindings.cpArbiterCallWildcardBeginB(_arbiterResource, space._toPointer) == 0 ? false : true;
  }

  bool callWildcardPreSolveA(Space space) {
    return bindings.cpArbiterCallWildcardPreSolveA(_arbiterResource, space._toPointer) == 0 ? false : true;
  }

  bool callWildcardPreSolveB(Space space) {
    return bindings.cpArbiterCallWildcardPreSolveB(_arbiterResource, space._toPointer) == 0 ? false : true;
  }

  void callWildcardPostSolveA(Space space) {
    bindings.cpArbiterCallWildcardPostSolveA(_arbiterResource, space._toPointer);
  }

  void callWildcardPostSolveB(Space space) {
    bindings.cpArbiterCallWildcardPostSolveB(_arbiterResource, space._toPointer);
  }

  void callWildcardSeparateA(Space space) {
    bindings.cpArbiterCallWildcardSeparateA(_arbiterResource, space._toPointer);
  }

  void callWildcardSeparateB(Space space) {
    bindings.cpArbiterCallWildcardSeparateB(_arbiterResource, space._toPointer);
  }
}

final _ar_data = HashMap<int, dynamic>();
