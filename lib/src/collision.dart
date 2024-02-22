// ignore_for_file: non_constant_identifier_names, unused_element

part of 'liquid2d.dart';

/// Struct that holds function callback pointers to configure custom collision handling.
/// Collision handlers have a pair of types; when a collision occurs between two shapes that have these types, the collision handler functions are triggered.
class CollisionHandler {
  late final CollisionHandlerResource _collisionHandler;
  CollisionHandler._fromPointer(Pointer<cpCollisionHandler> collisionHandler) : _collisionHandler = CollisionHandlerResource(collisionHandler);
  CollisionHandler._fromPointerSpaceAddWildcardHandler(Pointer<cpSpace> collisionHandler, int type) : _collisionHandler = CollisionHandlerResource._spaceAddWildcardHandler(collisionHandler, type);
  CollisionHandler._fromPointerSpaceAddCollisionHandler(Pointer<cpSpace> collisionHandler, int aType, int bType)
      : _collisionHandler = CollisionHandlerResource._spaceAddCollisionHandler(collisionHandler, aType, bType);
  CollisionHandler._fromPointerSpaceAddDefaultCollisionHandler(
    Pointer<cpSpace> collisionHandler,
  ) : _collisionHandler = CollisionHandlerResource._spaceAddDefaultCollisionHandler(collisionHandler);
  Pointer<cpCollisionHandler> get _toPointer => _collisionHandler.toPointer;

  /// This function is called each step when two shapes with types that match this collision handler are colliding.
  /// It's called before the collision solver runs so that you can affect a collision's outcome.
  void preSolve(bool Function(Arbiter arbiter, Space space) preSolveFunc) => _collisionHandler.preSolve(preSolveFunc);

  /// This function is called when two shapes with types that match this collision handler begin colliding.
  void begin(bool Function(Arbiter arbiter, Space space) beginFunc) => _collisionHandler.begin(beginFunc);

  /// This function is called each step when two shapes with types that match this collision handler are colliding.
  /// It's called after the collision solver runs so that you can read back information about the collision to trigger events in your game.
  void postSolve(void Function(Arbiter arbiter, Space space) postSolveFunc) => _collisionHandler.postSolve(postSolveFunc);

  /// This function is called when two shapes with types that match this collision handler stop colliding.
  void separate(void Function(Arbiter arbiter, Space space) separateFunc) => _collisionHandler.separate(separateFunc);

  /// Collision type identifier of the first shape that this handler recognizes.
  /// In the collision handler callback, the shape with this type will be the first argument. Read only.
  int get typeA => _collisionHandler.typeA;

  /// Collision type identifier of the second shape that this handler recognizes.
  /// In the collision handler callback, the shape with this type will be the second argument. Read only.
  int get typeb => _collisionHandler.typeB;
}

class CollisionHandlerResource {
  late Pointer<cpCollisionHandler> _collisionHandler;
  int cId = 0;
  Random random = Random.secure();
  int generateRandomInt(int min, int max) => Random().nextInt(max - min) + min;
  CollisionHandlerResource(this._collisionHandler);
  CollisionHandlerResource._spaceAddWildcardHandler(Pointer<cpSpace> space, int type) {
    cId = __calbackIdGen(generateRandomInt(0, 0x7fffffff), '_spaceAddWildcardHandler');
    _collisionHandler = bindings.cpSpaceAddWildcardHandler(space, type, cId);
  }
  CollisionHandlerResource._spaceAddCollisionHandler(Pointer<cpSpace> space, int aType, int bType) {
    cId = __calbackIdGen(generateRandomInt(0, 0x7fffffff), '_spaceAddCollisionHandler');
    _collisionHandler = bindings.cpSpaceAddCollisionHandler(space, aType, bType, cId);
  }

  CollisionHandlerResource._spaceAddDefaultCollisionHandler(Pointer<cpSpace> space) {
    cId = __calbackIdGen(generateRandomInt(0, 0x7fffffff), '_spaceAddDefaultCollisionHandler');
    _collisionHandler = bindings.cpSpaceAddDefaultCollisionHandler(space, cId);
  }

  Pointer<cpCollisionHandler> get toPointer => _collisionHandler;
  void preSolve(bool Function(Arbiter arbiter, Space space) preSolveFunc) {
    _c_preSolve_callbacks[cId] = preSolveFunc;
    _collisionHandler.ref.preSolveFunc = Pointer.fromFunction(preSolveCallback, 0);
  }

  void begin(bool Function(Arbiter arbiter, Space space) beginFunc) {
    _c_begin_callbacks[cId] = beginFunc;
    _collisionHandler.ref.beginFunc = Pointer.fromFunction(beginCallback, 0);
  }

  void postSolve(void Function(Arbiter arbiter, Space space) postSolveFunc) {
    _c_postSolve_callbacks[cId] = postSolveFunc;
    _collisionHandler.ref.postSolveFunc = Pointer.fromFunction(postSolveCallback);
  }

  void separate(void Function(Arbiter arbiter, Space space) separateFunc) {
    _c_separate_callbacks[cId] = separateFunc;
    _collisionHandler.ref.separateFunc = Pointer.fromFunction(separateCallback);
  }

  int get typeA => _collisionHandler.ref.typeA;
  int get typeB => _collisionHandler.ref.typeB;
}

int preSolveCallback(Pointer<cpArbiter> arbiter, Pointer<cpSpace> space, Pointer<Void> data, int callbackId) {
  return _c_preSolve_callbacks[callbackId]!.call(Arbiter._fromPointer(arbiter), Space._fromPointer(space)) ? 1 : 0;
}

void postSolveCallback(Pointer<cpArbiter> arbiter, Pointer<cpSpace> space, Pointer<Void> data, int callbackId) {
  _c_postSolve_callbacks[callbackId]!.call(Arbiter._fromPointer(arbiter), Space._fromPointer(space));
}

void separateCallback(Pointer<cpArbiter> arbiter, Pointer<cpSpace> space, Pointer<Void> data, int callbackId) {
  _c_separate_callbacks[callbackId]!.call(Arbiter._fromPointer(arbiter), Space._fromPointer(space));
}

int beginCallback(Pointer<cpArbiter> arbiter, Pointer<cpSpace> space, Pointer<Void> data, int callbackId) {
  return _c_begin_callbacks[callbackId]!.call(Arbiter._fromPointer(arbiter), Space._fromPointer(space)) ? 1 : 0;
}

var _c_preSolve_callbacks = HashMap<int, bool Function(Arbiter, Space)>();
var _c_begin_callbacks = HashMap<int, bool Function(Arbiter, Space)>();
var _c_postSolve_callbacks = HashMap<int, void Function(Arbiter, Space)>();
var _c_separate_callbacks = HashMap<int, void Function(Arbiter, Space)>();
