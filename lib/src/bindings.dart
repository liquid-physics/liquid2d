// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: unused_field
import 'dart:ffi' as ffi;

class Chipmunks {
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) _lookup;

  Chipmunks(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup {
    // space_free_native = _cpSpaceFreePtr.cast();
    // body_free_native = _cpBodyFreePtr.cast();
    // shape_free_native = _cpShapeFreePtr.cast();
  }

  Chipmunks.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup) : _lookup = lookup;
  ffi.Pointer<cpSpace> cpSpaceNew() {
    return _cpSpaceNew();
  }

  late final _cpSpaceNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function()>>('cpSpaceNew');
  late final _cpSpaceNew = _cpSpaceNewPtr.asFunction<ffi.Pointer<cpSpace> Function()>();

  void cpSpaceSetGravity(
    ffi.Pointer<cpSpace> space,
    cpVect gravity,
  ) {
    return _cpSpaceSetGravity(
      space,
      gravity,
    );
  }

  late final _cpSpaceSetGravityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpVect)>>('cpSpaceSetGravity');
  late final _cpSpaceSetGravity = _cpSpaceSetGravityPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpVect)>();

  ffi.Pointer<cpShape> cpSegmentShapeNew(
    ffi.Pointer<cpBody> body,
    cpVect a,
    cpVect b,
    double radius,
  ) {
    return _cpSegmentShapeNew(
      body,
      a,
      b,
      radius,
    );
  }

  late final _cpSegmentShapeNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat)>>('cpSegmentShapeNew');
  late final _cpSegmentShapeNew = _cpSegmentShapeNewPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpVect, cpVect, double)>();

  ffi.Pointer<cpBody> cpSpaceGetStaticBody(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetStaticBody(
      space,
    );
  }

  late final _cpSpaceGetStaticBodyPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetStaticBody');
  late final _cpSpaceGetStaticBody = _cpSpaceGetStaticBodyPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpSpace>)>();

  void cpShapeSetFriction(
    ffi.Pointer<cpShape> shape,
    double friction,
  ) {
    return _cpShapeSetFriction(
      shape,
      friction,
    );
  }

  late final _cpShapeSetFrictionPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpShapeSetFriction');
  late final _cpShapeSetFriction = _cpShapeSetFrictionPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  ffi.Pointer<cpShape> cpSpaceAddShape(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSpaceAddShape(
      space,
      shape,
    );
  }

  late final _cpSpaceAddShapePtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>>('cpSpaceAddShape');
  late final _cpSpaceAddShape = _cpSpaceAddShapePtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>();

  double cpMomentForCircle(
    double m,
    double r1,
    double r2,
    cpVect offset,
  ) {
    return _cpMomentForCircle(
      m,
      r1,
      r2,
      offset,
    );
  }

  late final _cpMomentForCirclePtr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, cpFloat, cpFloat, cpVect)>>('cpMomentForCircle');
  late final _cpMomentForCircle = _cpMomentForCirclePtr.asFunction<double Function(double, double, double, cpVect)>();

  ffi.Pointer<cpBody> cpSpaceAddBody(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpBody> body,
  ) {
    return _cpSpaceAddBody(
      space,
      body,
    );
  }

  late final _cpSpaceAddBodyPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>>('cpSpaceAddBody');
  late final _cpSpaceAddBody = _cpSpaceAddBodyPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>();

  void cpBodySetPosition(
    ffi.Pointer<cpBody> body,
    cpVect pos,
  ) {
    return _cpBodySetPosition(
      body,
      pos,
    );
  }

  late final _cpBodySetPositionPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodySetPosition');
  late final _cpBodySetPosition = _cpBodySetPositionPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect)>();

  cpVect cpBodyGetPosition(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetPosition(
      body,
    );
  }

  late final _cpBodyGetPositionPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>)>>('cpBodyGetPosition');
  late final _cpBodyGetPosition = _cpBodyGetPositionPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>)>();

  cpVect cpBodyGetVelocity(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetVelocity(
      body,
    );
  }

  late final _cpBodyGetVelocityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>)>>('cpBodyGetVelocity');
  late final _cpBodyGetVelocity = _cpBodyGetVelocityPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>)>();

  void cpSpaceStep(
    ffi.Pointer<cpSpace> space,
    double dt,
  ) {
    return _cpSpaceStep(
      space,
      dt,
    );
  }

  late final _cpSpaceStepPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceStep');
  late final _cpSpaceStep = _cpSpaceStepPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  void cpShapeFree(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeFree(
      shape,
    );
  }

  //late ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape)>> shape_free_native;
  late final _cpShapeFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>)>>('cpShapeFree');
  late final _cpShapeFree = _cpShapeFreePtr.asFunction<void Function(ffi.Pointer<cpShape>)>();

  void cpBodyFree(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyFree(
      body,
    );
  }

  //late ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body)>> body_free_native;
  late final _cpBodyFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>)>>('cpBodyFree');
  late final _cpBodyFree = _cpBodyFreePtr.asFunction<void Function(ffi.Pointer<cpBody>)>();

  void cpSpaceFree(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceFree(
      space,
    );
  }

  //late ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace> space)>> space_free_native;
  late final _cpSpaceFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>)>>('cpSpaceFree');
  late final _cpSpaceFree = _cpSpaceFreePtr.asFunction<void Function(ffi.Pointer<cpSpace>)>();

  ffi.Pointer<cpBody> cpBodyNew(
    double mass,
    double moment,
  ) {
    return _cpBodyNew(
      mass,
      moment,
    );
  }

  late final _cpBodyNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(cpFloat, cpFloat)>>('cpBodyNew');
  late final _cpBodyNew = _cpBodyNewPtr.asFunction<ffi.Pointer<cpBody> Function(double, double)>();

  ffi.Pointer<cpShape> cpCircleShapeNew(
    ffi.Pointer<cpBody> body,
    double radius,
    cpVect offset,
  ) {
    return _cpCircleShapeNew(
      body,
      radius,
      offset,
    );
  }

  late final _cpCircleShapeNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpFloat, cpVect)>>('cpCircleShapeNew');
  late final _cpCircleShapeNew = _cpCircleShapeNewPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, double, cpVect)>();

  void cpMessage(
    ffi.Pointer<ffi.Char> condition,
    ffi.Pointer<ffi.Char> file,
    int line,
    int isError,
    int isHardError,
    ffi.Pointer<ffi.Char> message,
  ) {
    return _cpMessage(
      condition,
      file,
      line,
      isError,
      isHardError,
      message,
    );
  }

  late final _cpMessagePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>, ffi.Int, ffi.Int, ffi.Int, ffi.Pointer<ffi.Char>)>>('cpMessage');
  late final _cpMessage = _cpMessagePtr.asFunction<void Function(ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>, int, int, int, ffi.Pointer<ffi.Char>)>();

  late final ffi.Pointer<ffi.Pointer<ffi.Char>> _cpVersionString = _lookup<ffi.Pointer<ffi.Char>>('cpVersionString');

  ffi.Pointer<ffi.Char> get cpVersionString => _cpVersionString.value;

  set cpVersionString(ffi.Pointer<ffi.Char> value) => _cpVersionString.value = value;

  double cpAreaForCircle(
    double r1,
    double r2,
  ) {
    return _cpAreaForCircle(
      r1,
      r2,
    );
  }

  late final _cpAreaForCirclePtr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, cpFloat)>>('cpAreaForCircle');
  late final _cpAreaForCircle = _cpAreaForCirclePtr.asFunction<double Function(double, double)>();

  double cpMomentForSegment(
    double m,
    cpVect a,
    cpVect b,
    double radius,
  ) {
    return _cpMomentForSegment(
      m,
      a,
      b,
      radius,
    );
  }

  late final _cpMomentForSegmentPtr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, cpVect, cpVect, cpFloat)>>('cpMomentForSegment');
  late final _cpMomentForSegment = _cpMomentForSegmentPtr.asFunction<double Function(double, cpVect, cpVect, double)>();

  double cpAreaForSegment(
    cpVect a,
    cpVect b,
    double radius,
  ) {
    return _cpAreaForSegment(
      a,
      b,
      radius,
    );
  }

  late final _cpAreaForSegmentPtr = _lookup<ffi.NativeFunction<cpFloat Function(cpVect, cpVect, cpFloat)>>('cpAreaForSegment');
  late final _cpAreaForSegment = _cpAreaForSegmentPtr.asFunction<double Function(cpVect, cpVect, double)>();

  double cpMomentForPoly(
    double m,
    int count,
    ffi.Pointer<cpVect> verts,
    cpVect offset,
    double radius,
  ) {
    return _cpMomentForPoly(
      m,
      count,
      verts,
      offset,
      radius,
    );
  }

  late final _cpMomentForPolyPtr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, ffi.Int, ffi.Pointer<cpVect>, cpVect, cpFloat)>>('cpMomentForPoly');
  late final _cpMomentForPoly = _cpMomentForPolyPtr.asFunction<double Function(double, int, ffi.Pointer<cpVect>, cpVect, double)>();

  double cpAreaForPoly(
    int count,
    ffi.Pointer<cpVect> verts,
    double radius,
  ) {
    return _cpAreaForPoly(
      count,
      verts,
      radius,
    );
  }

  late final _cpAreaForPolyPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Int, ffi.Pointer<cpVect>, cpFloat)>>('cpAreaForPoly');
  late final _cpAreaForPoly = _cpAreaForPolyPtr.asFunction<double Function(int, ffi.Pointer<cpVect>, double)>();

  cpVect cpCentroidForPoly(
    int count,
    ffi.Pointer<cpVect> verts,
  ) {
    return _cpCentroidForPoly(
      count,
      verts,
    );
  }

  late final _cpCentroidForPolyPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Int, ffi.Pointer<cpVect>)>>('cpCentroidForPoly');
  late final _cpCentroidForPoly = _cpCentroidForPolyPtr.asFunction<cpVect Function(int, ffi.Pointer<cpVect>)>();

  double cpMomentForBox(
    double m,
    double width,
    double height,
  ) {
    return _cpMomentForBox(
      m,
      width,
      height,
    );
  }

  late final _cpMomentForBoxPtr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, cpFloat, cpFloat)>>('cpMomentForBox');
  late final _cpMomentForBox = _cpMomentForBoxPtr.asFunction<double Function(double, double, double)>();

  double cpMomentForBox2(
    double m,
    cpBB box,
  ) {
    return _cpMomentForBox2(
      m,
      box,
    );
  }

  late final _cpMomentForBox2Ptr = _lookup<ffi.NativeFunction<cpFloat Function(cpFloat, cpBB)>>('cpMomentForBox2');
  late final _cpMomentForBox2 = _cpMomentForBox2Ptr.asFunction<double Function(double, cpBB)>();

  int cpConvexHull(
    int count,
    ffi.Pointer<cpVect> verts,
    ffi.Pointer<cpVect> result,
    ffi.Pointer<ffi.Int> first,
    double tol,
  ) {
    return _cpConvexHull(
      count,
      verts,
      result,
      first,
      tol,
    );
  }

  late final _cpConvexHullPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Int, ffi.Pointer<cpVect>, ffi.Pointer<cpVect>, ffi.Pointer<ffi.Int>, cpFloat)>>('cpConvexHull');
  late final _cpConvexHull = _cpConvexHullPtr.asFunction<int Function(int, ffi.Pointer<cpVect>, ffi.Pointer<cpVect>, ffi.Pointer<ffi.Int>, double)>();

  double cpArbiterGetRestitution(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetRestitution(
      arb,
    );
  }

  late final _cpArbiterGetRestitutionPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetRestitution');
  late final _cpArbiterGetRestitution = _cpArbiterGetRestitutionPtr.asFunction<double Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterSetRestitution(
    ffi.Pointer<cpArbiter> arb,
    double restitution,
  ) {
    return _cpArbiterSetRestitution(
      arb,
      restitution,
    );
  }

  late final _cpArbiterSetRestitutionPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, cpFloat)>>('cpArbiterSetRestitution');
  late final _cpArbiterSetRestitution = _cpArbiterSetRestitutionPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, double)>();

  double cpArbiterGetFriction(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetFriction(
      arb,
    );
  }

  late final _cpArbiterGetFrictionPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetFriction');
  late final _cpArbiterGetFriction = _cpArbiterGetFrictionPtr.asFunction<double Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterSetFriction(
    ffi.Pointer<cpArbiter> arb,
    double friction,
  ) {
    return _cpArbiterSetFriction(
      arb,
      friction,
    );
  }

  late final _cpArbiterSetFrictionPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, cpFloat)>>('cpArbiterSetFriction');
  late final _cpArbiterSetFriction = _cpArbiterSetFrictionPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, double)>();

  cpVect cpArbiterGetSurfaceVelocity(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetSurfaceVelocity(
      arb,
    );
  }

  late final _cpArbiterGetSurfaceVelocityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetSurfaceVelocity');
  late final _cpArbiterGetSurfaceVelocity = _cpArbiterGetSurfaceVelocityPtr.asFunction<cpVect Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterSetSurfaceVelocity(
    ffi.Pointer<cpArbiter> arb,
    cpVect vr,
  ) {
    return _cpArbiterSetSurfaceVelocity(
      arb,
      vr,
    );
  }

  late final _cpArbiterSetSurfaceVelocityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, cpVect)>>('cpArbiterSetSurfaceVelocity');
  late final _cpArbiterSetSurfaceVelocity = _cpArbiterSetSurfaceVelocityPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, cpVect)>();

  cpDataPointer cpArbiterGetUserData(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetUserData(
      arb,
    );
  }

  late final _cpArbiterGetUserDataPtr = _lookup<ffi.NativeFunction<cpDataPointer Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetUserData');
  late final _cpArbiterGetUserData = _cpArbiterGetUserDataPtr.asFunction<cpDataPointer Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterSetUserData(
    ffi.Pointer<cpArbiter> arb,
    cpDataPointer userData,
  ) {
    return _cpArbiterSetUserData(
      arb,
      userData,
    );
  }

  late final _cpArbiterSetUserDataPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, cpDataPointer)>>('cpArbiterSetUserData');
  late final _cpArbiterSetUserData = _cpArbiterSetUserDataPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, cpDataPointer)>();

  cpVect cpArbiterTotalImpulse(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterTotalImpulse(
      arb,
    );
  }

  late final _cpArbiterTotalImpulsePtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpArbiter>)>>('cpArbiterTotalImpulse');
  late final _cpArbiterTotalImpulse = _cpArbiterTotalImpulsePtr.asFunction<cpVect Function(ffi.Pointer<cpArbiter>)>();

  double cpArbiterTotalKE(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterTotalKE(
      arb,
    );
  }

  late final _cpArbiterTotalKEPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpArbiter>)>>('cpArbiterTotalKE');
  late final _cpArbiterTotalKE = _cpArbiterTotalKEPtr.asFunction<double Function(ffi.Pointer<cpArbiter>)>();

  int cpArbiterIgnore(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterIgnore(
      arb,
    );
  }

  late final _cpArbiterIgnorePtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>)>>('cpArbiterIgnore');
  late final _cpArbiterIgnore = _cpArbiterIgnorePtr.asFunction<int Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterGetShapes(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<ffi.Pointer<cpShape>> a,
    ffi.Pointer<ffi.Pointer<cpShape>> b,
  ) {
    return _cpArbiterGetShapes(
      arb,
      a,
      b,
    );
  }

  late final _cpArbiterGetShapesPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<ffi.Pointer<cpShape>>, ffi.Pointer<ffi.Pointer<cpShape>>)>>('cpArbiterGetShapes');
  late final _cpArbiterGetShapes = _cpArbiterGetShapesPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<ffi.Pointer<cpShape>>, ffi.Pointer<ffi.Pointer<cpShape>>)>();

  void cpArbiterGetBodies(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<ffi.Pointer<cpBody>> a,
    ffi.Pointer<ffi.Pointer<cpBody>> b,
  ) {
    return _cpArbiterGetBodies(
      arb,
      a,
      b,
    );
  }

  late final _cpArbiterGetBodiesPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<ffi.Pointer<cpBody>>, ffi.Pointer<ffi.Pointer<cpBody>>)>>('cpArbiterGetBodies');
  late final _cpArbiterGetBodies = _cpArbiterGetBodiesPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<ffi.Pointer<cpBody>>, ffi.Pointer<ffi.Pointer<cpBody>>)>();

  cpContactPointSet cpArbiterGetContactPointSet(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetContactPointSet(
      arb,
    );
  }

  late final _cpArbiterGetContactPointSetPtr = _lookup<ffi.NativeFunction<cpContactPointSet Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetContactPointSet');
  late final _cpArbiterGetContactPointSet = _cpArbiterGetContactPointSetPtr.asFunction<cpContactPointSet Function(ffi.Pointer<cpArbiter>)>();

  void cpArbiterSetContactPointSet(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpContactPointSet> set1,
  ) {
    return _cpArbiterSetContactPointSet(
      arb,
      set1,
    );
  }

  late final _cpArbiterSetContactPointSetPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpContactPointSet>)>>('cpArbiterSetContactPointSet');
  late final _cpArbiterSetContactPointSet = _cpArbiterSetContactPointSetPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpContactPointSet>)>();

  int cpArbiterIsFirstContact(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterIsFirstContact(
      arb,
    );
  }

  late final _cpArbiterIsFirstContactPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>)>>('cpArbiterIsFirstContact');
  late final _cpArbiterIsFirstContact = _cpArbiterIsFirstContactPtr.asFunction<int Function(ffi.Pointer<cpArbiter>)>();

  int cpArbiterIsRemoval(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterIsRemoval(
      arb,
    );
  }

  late final _cpArbiterIsRemovalPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>)>>('cpArbiterIsRemoval');
  late final _cpArbiterIsRemoval = _cpArbiterIsRemovalPtr.asFunction<int Function(ffi.Pointer<cpArbiter>)>();

  int cpArbiterGetCount(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetCount(
      arb,
    );
  }

  late final _cpArbiterGetCountPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetCount');
  late final _cpArbiterGetCount = _cpArbiterGetCountPtr.asFunction<int Function(ffi.Pointer<cpArbiter>)>();

  cpVect cpArbiterGetNormal(
    ffi.Pointer<cpArbiter> arb,
  ) {
    return _cpArbiterGetNormal(
      arb,
    );
  }

  late final _cpArbiterGetNormalPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpArbiter>)>>('cpArbiterGetNormal');
  late final _cpArbiterGetNormal = _cpArbiterGetNormalPtr.asFunction<cpVect Function(ffi.Pointer<cpArbiter>)>();

  cpVect cpArbiterGetPointA(
    ffi.Pointer<cpArbiter> arb,
    int i,
  ) {
    return _cpArbiterGetPointA(
      arb,
      i,
    );
  }

  late final _cpArbiterGetPointAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpArbiter>, ffi.Int)>>('cpArbiterGetPointA');
  late final _cpArbiterGetPointA = _cpArbiterGetPointAPtr.asFunction<cpVect Function(ffi.Pointer<cpArbiter>, int)>();

  cpVect cpArbiterGetPointB(
    ffi.Pointer<cpArbiter> arb,
    int i,
  ) {
    return _cpArbiterGetPointB(
      arb,
      i,
    );
  }

  late final _cpArbiterGetPointBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpArbiter>, ffi.Int)>>('cpArbiterGetPointB');
  late final _cpArbiterGetPointB = _cpArbiterGetPointBPtr.asFunction<cpVect Function(ffi.Pointer<cpArbiter>, int)>();

  double cpArbiterGetDepth(
    ffi.Pointer<cpArbiter> arb,
    int i,
  ) {
    return _cpArbiterGetDepth(
      arb,
      i,
    );
  }

  late final _cpArbiterGetDepthPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpArbiter>, ffi.Int)>>('cpArbiterGetDepth');
  late final _cpArbiterGetDepth = _cpArbiterGetDepthPtr.asFunction<double Function(ffi.Pointer<cpArbiter>, int)>();

  int cpArbiterCallWildcardBeginA(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardBeginA(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardBeginAPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardBeginA');
  late final _cpArbiterCallWildcardBeginA = _cpArbiterCallWildcardBeginAPtr.asFunction<int Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  int cpArbiterCallWildcardBeginB(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardBeginB(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardBeginBPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardBeginB');
  late final _cpArbiterCallWildcardBeginB = _cpArbiterCallWildcardBeginBPtr.asFunction<int Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  int cpArbiterCallWildcardPreSolveA(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardPreSolveA(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardPreSolveAPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardPreSolveA');
  late final _cpArbiterCallWildcardPreSolveA = _cpArbiterCallWildcardPreSolveAPtr.asFunction<int Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  int cpArbiterCallWildcardPreSolveB(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardPreSolveB(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardPreSolveBPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardPreSolveB');
  late final _cpArbiterCallWildcardPreSolveB = _cpArbiterCallWildcardPreSolveBPtr.asFunction<int Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  void cpArbiterCallWildcardPostSolveA(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardPostSolveA(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardPostSolveAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardPostSolveA');
  late final _cpArbiterCallWildcardPostSolveA = _cpArbiterCallWildcardPostSolveAPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  void cpArbiterCallWildcardPostSolveB(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardPostSolveB(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardPostSolveBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardPostSolveB');
  late final _cpArbiterCallWildcardPostSolveB = _cpArbiterCallWildcardPostSolveBPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  void cpArbiterCallWildcardSeparateA(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardSeparateA(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardSeparateAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardSeparateA');
  late final _cpArbiterCallWildcardSeparateA = _cpArbiterCallWildcardSeparateAPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  void cpArbiterCallWildcardSeparateB(
    ffi.Pointer<cpArbiter> arb,
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpArbiterCallWildcardSeparateB(
      arb,
      space,
    );
  }

  late final _cpArbiterCallWildcardSeparateBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>>('cpArbiterCallWildcardSeparateB');
  late final _cpArbiterCallWildcardSeparateB = _cpArbiterCallWildcardSeparateBPtr.asFunction<void Function(ffi.Pointer<cpArbiter>, ffi.Pointer<cpSpace>)>();

  ffi.Pointer<cpBody> cpBodyAlloc() {
    return _cpBodyAlloc();
  }

  late final _cpBodyAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function()>>('cpBodyAlloc');
  late final _cpBodyAlloc = _cpBodyAllocPtr.asFunction<ffi.Pointer<cpBody> Function()>();

  ffi.Pointer<cpBody> cpBodyInit(
    ffi.Pointer<cpBody> body,
    double mass,
    double moment,
  ) {
    return _cpBodyInit(
      body,
      mass,
      moment,
    );
  }

  late final _cpBodyInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpBodyInit');
  late final _cpBodyInit = _cpBodyInitPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpBody>, double, double)>();

  ffi.Pointer<cpBody> cpBodyNewKinematic() {
    return _cpBodyNewKinematic();
  }

  late final _cpBodyNewKinematicPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function()>>('cpBodyNewKinematic');
  late final _cpBodyNewKinematic = _cpBodyNewKinematicPtr.asFunction<ffi.Pointer<cpBody> Function()>();

  ffi.Pointer<cpBody> cpBodyNewStatic() {
    return _cpBodyNewStatic();
  }

  late final _cpBodyNewStaticPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function()>>('cpBodyNewStatic');
  late final _cpBodyNewStatic = _cpBodyNewStaticPtr.asFunction<ffi.Pointer<cpBody> Function()>();

  void cpBodyDestroy(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyDestroy(
      body,
    );
  }

  late final _cpBodyDestroyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>)>>('cpBodyDestroy');
  late final _cpBodyDestroy = _cpBodyDestroyPtr.asFunction<void Function(ffi.Pointer<cpBody>)>();

  void cpBodyActivate(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyActivate(
      body,
    );
  }

  late final _cpBodyActivatePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>)>>('cpBodyActivate');
  late final _cpBodyActivate = _cpBodyActivatePtr.asFunction<void Function(ffi.Pointer<cpBody>)>();

  void cpBodyActivateStatic(
    ffi.Pointer<cpBody> body,
    ffi.Pointer<cpShape> filter,
  ) {
    return _cpBodyActivateStatic(
      body,
      filter,
    );
  }

  late final _cpBodyActivateStaticPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, ffi.Pointer<cpShape>)>>('cpBodyActivateStatic');
  late final _cpBodyActivateStatic = _cpBodyActivateStaticPtr.asFunction<void Function(ffi.Pointer<cpBody>, ffi.Pointer<cpShape>)>();

  void cpBodySleep(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodySleep(
      body,
    );
  }

  late final _cpBodySleepPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>)>>('cpBodySleep');
  late final _cpBodySleep = _cpBodySleepPtr.asFunction<void Function(ffi.Pointer<cpBody>)>();

  void cpBodySleepWithGroup(
    ffi.Pointer<cpBody> body,
    ffi.Pointer<cpBody> group,
  ) {
    return _cpBodySleepWithGroup(
      body,
      group,
    );
  }

  late final _cpBodySleepWithGroupPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>)>>('cpBodySleepWithGroup');
  late final _cpBodySleepWithGroup = _cpBodySleepWithGroupPtr.asFunction<void Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>)>();

  int cpBodyIsSleeping(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyIsSleeping(
      body,
    );
  }

  late final _cpBodyIsSleepingPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpBody>)>>('cpBodyIsSleeping');
  late final _cpBodyIsSleeping = _cpBodyIsSleepingPtr.asFunction<int Function(ffi.Pointer<cpBody>)>();

  int cpBodyGetType(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetType(
      body,
    );
  }

  late final _cpBodyGetTypePtr = _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<cpBody>)>>('cpBodyGetType');
  late final _cpBodyGetType = _cpBodyGetTypePtr.asFunction<int Function(ffi.Pointer<cpBody>)>();

  void cpBodySetType(
    ffi.Pointer<cpBody> body,
    int type,
  ) {
    return _cpBodySetType(
      body,
      type,
    );
  }

  late final _cpBodySetTypePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, ffi.Int32)>>('cpBodySetType');
  late final _cpBodySetType = _cpBodySetTypePtr.asFunction<void Function(ffi.Pointer<cpBody>, int)>();

  ffi.Pointer<cpSpace> cpBodyGetSpace(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetSpace(
      body,
    );
  }

  late final _cpBodyGetSpacePtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpBody>)>>('cpBodyGetSpace');
  late final _cpBodyGetSpace = _cpBodyGetSpacePtr.asFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpBody>)>();

  double cpBodyGetMass(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetMass(
      body,
    );
  }

  late final _cpBodyGetMassPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyGetMass');
  late final _cpBodyGetMass = _cpBodyGetMassPtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodySetMass(
    ffi.Pointer<cpBody> body,
    double m,
  ) {
    return _cpBodySetMass(
      body,
      m,
    );
  }

  late final _cpBodySetMassPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat)>>('cpBodySetMass');
  late final _cpBodySetMass = _cpBodySetMassPtr.asFunction<void Function(ffi.Pointer<cpBody>, double)>();

  double cpBodyGetMoment(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetMoment(
      body,
    );
  }

  late final _cpBodyGetMomentPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyGetMoment');
  late final _cpBodyGetMoment = _cpBodyGetMomentPtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodySetMoment(
    ffi.Pointer<cpBody> body,
    double i,
  ) {
    return _cpBodySetMoment(
      body,
      i,
    );
  }

  late final _cpBodySetMomentPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat)>>('cpBodySetMoment');
  late final _cpBodySetMoment = _cpBodySetMomentPtr.asFunction<void Function(ffi.Pointer<cpBody>, double)>();

  cpVect cpBodyGetCenterOfGravity(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetCenterOfGravity(
      body,
    );
  }

  late final _cpBodyGetCenterOfGravityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>)>>('cpBodyGetCenterOfGravity');
  late final _cpBodyGetCenterOfGravity = _cpBodyGetCenterOfGravityPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>)>();

  void cpBodySetCenterOfGravity(
    ffi.Pointer<cpBody> body,
    cpVect cog,
  ) {
    return _cpBodySetCenterOfGravity(
      body,
      cog,
    );
  }

  late final _cpBodySetCenterOfGravityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodySetCenterOfGravity');
  late final _cpBodySetCenterOfGravity = _cpBodySetCenterOfGravityPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect)>();

  void cpBodySetVelocity(
    ffi.Pointer<cpBody> body,
    cpVect velocity,
  ) {
    return _cpBodySetVelocity(
      body,
      velocity,
    );
  }

  late final _cpBodySetVelocityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodySetVelocity');
  late final _cpBodySetVelocity = _cpBodySetVelocityPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect)>();

  cpVect cpBodyGetForce(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetForce(
      body,
    );
  }

  late final _cpBodyGetForcePtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>)>>('cpBodyGetForce');
  late final _cpBodyGetForce = _cpBodyGetForcePtr.asFunction<cpVect Function(ffi.Pointer<cpBody>)>();

  void cpBodySetForce(
    ffi.Pointer<cpBody> body,
    cpVect force,
  ) {
    return _cpBodySetForce(
      body,
      force,
    );
  }

  late final _cpBodySetForcePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodySetForce');
  late final _cpBodySetForce = _cpBodySetForcePtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect)>();

  double cpBodyGetAngle(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetAngle(
      body,
    );
  }

  late final _cpBodyGetAnglePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyGetAngle');
  late final _cpBodyGetAngle = _cpBodyGetAnglePtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodySetAngle(
    ffi.Pointer<cpBody> body,
    double a,
  ) {
    return _cpBodySetAngle(
      body,
      a,
    );
  }

  late final _cpBodySetAnglePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat)>>('cpBodySetAngle');
  late final _cpBodySetAngle = _cpBodySetAnglePtr.asFunction<void Function(ffi.Pointer<cpBody>, double)>();

  double cpBodyGetAngularVelocity(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetAngularVelocity(
      body,
    );
  }

  late final _cpBodyGetAngularVelocityPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyGetAngularVelocity');
  late final _cpBodyGetAngularVelocity = _cpBodyGetAngularVelocityPtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodySetAngularVelocity(
    ffi.Pointer<cpBody> body,
    double angularVelocity,
  ) {
    return _cpBodySetAngularVelocity(
      body,
      angularVelocity,
    );
  }

  late final _cpBodySetAngularVelocityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat)>>('cpBodySetAngularVelocity');
  late final _cpBodySetAngularVelocity = _cpBodySetAngularVelocityPtr.asFunction<void Function(ffi.Pointer<cpBody>, double)>();

  double cpBodyGetTorque(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetTorque(
      body,
    );
  }

  late final _cpBodyGetTorquePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyGetTorque');
  late final _cpBodyGetTorque = _cpBodyGetTorquePtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodySetTorque(
    ffi.Pointer<cpBody> body,
    double torque,
  ) {
    return _cpBodySetTorque(
      body,
      torque,
    );
  }

  late final _cpBodySetTorquePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat)>>('cpBodySetTorque');
  late final _cpBodySetTorque = _cpBodySetTorquePtr.asFunction<void Function(ffi.Pointer<cpBody>, double)>();

  cpVect cpBodyGetRotation(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetRotation(
      body,
    );
  }

  late final _cpBodyGetRotationPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>)>>('cpBodyGetRotation');
  late final _cpBodyGetRotation = _cpBodyGetRotationPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>)>();

  cpDataPointer cpBodyGetUserData(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyGetUserData(
      body,
    );
  }

  late final _cpBodyGetUserDataPtr = _lookup<ffi.NativeFunction<cpDataPointer Function(ffi.Pointer<cpBody>)>>('cpBodyGetUserData');
  late final _cpBodyGetUserData = _cpBodyGetUserDataPtr.asFunction<cpDataPointer Function(ffi.Pointer<cpBody>)>();

  void cpBodySetUserData(
    ffi.Pointer<cpBody> body,
    cpDataPointer userData,
  ) {
    return _cpBodySetUserData(
      body,
      userData,
    );
  }

  late final _cpBodySetUserDataPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpDataPointer)>>('cpBodySetUserData');
  late final _cpBodySetUserData = _cpBodySetUserDataPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpDataPointer)>();

  void cpBodySetVelocityUpdateFunc(
    ffi.Pointer<cpBody> body,
    cpBodyVelocityFuncD velocityFunc,
    int callbackId,
  ) {
    return _cpBodySetVelocityUpdateFunc(
      body,
      velocityFunc,
      callbackId,
    );
  }

  late final _cpBodySetVelocityUpdateFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpBodyVelocityFuncD, ffi.Uint64)>>('cpBodySetVelocityUpdateFunc');
  late final _cpBodySetVelocityUpdateFunc = _cpBodySetVelocityUpdateFuncPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpBodyVelocityFuncD, int)>();

  void cpBodySetPositionUpdateFunc(
    ffi.Pointer<cpBody> body,
    cpBodyPositionFuncD positionFunc,
    int callbackId,
  ) {
    return _cpBodySetPositionUpdateFunc(
      body,
      positionFunc,
      callbackId,
    );
  }

  late final _cpBodySetPositionUpdateFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpBodyPositionFuncD, ffi.Uint64)>>('cpBodySetPositionUpdateFunc');
  late final _cpBodySetPositionUpdateFunc = _cpBodySetPositionUpdateFuncPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpBodyPositionFuncD, int)>();

  void cpBodyUpdateVelocity(
    ffi.Pointer<cpBody> body,
    cpVect gravity,
    double damping,
    double dt,
    int callbackId,
  ) {
    return _cpBodyUpdateVelocity(
      body,
      gravity,
      damping,
      dt,
      callbackId,
    );
  }

  late final _cpBodyUpdateVelocityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect, cpFloat, cpFloat, ffi.Uint64)>>('cpBodyUpdateVelocity');
  late final _cpBodyUpdateVelocity = _cpBodyUpdateVelocityPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect, double, double, int)>();
  void cpBodyUpdatePosition(
    ffi.Pointer<cpBody> body,
    double dt,
    int callbackId,
  ) {
    return _cpBodyUpdatePosition(
      body,
      dt,
      callbackId,
    );
  }

  late final _cpBodyUpdatePositionPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpFloat, ffi.Uint64)>>('cpBodyUpdatePosition');
  late final _cpBodyUpdatePosition = _cpBodyUpdatePositionPtr.asFunction<void Function(ffi.Pointer<cpBody>, double, int)>();

  cpVect cpBodyLocalToWorld(
    ffi.Pointer<cpBody> body,
    cpVect point,
  ) {
    return _cpBodyLocalToWorld(
      body,
      point,
    );
  }

  late final _cpBodyLocalToWorldPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodyLocalToWorld');
  late final _cpBodyLocalToWorld = _cpBodyLocalToWorldPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>();

  cpVect cpBodyWorldToLocal(
    ffi.Pointer<cpBody> body,
    cpVect point,
  ) {
    return _cpBodyWorldToLocal(
      body,
      point,
    );
  }

  late final _cpBodyWorldToLocalPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodyWorldToLocal');
  late final _cpBodyWorldToLocal = _cpBodyWorldToLocalPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>();

  void cpBodyApplyForceAtWorldPoint(
    ffi.Pointer<cpBody> body,
    cpVect force,
    cpVect point,
  ) {
    return _cpBodyApplyForceAtWorldPoint(
      body,
      force,
      point,
    );
  }

  late final _cpBodyApplyForceAtWorldPointPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpBodyApplyForceAtWorldPoint');
  late final _cpBodyApplyForceAtWorldPoint = _cpBodyApplyForceAtWorldPointPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>();

  void cpBodyApplyForceAtLocalPoint(
    ffi.Pointer<cpBody> body,
    cpVect force,
    cpVect point,
  ) {
    return _cpBodyApplyForceAtLocalPoint(
      body,
      force,
      point,
    );
  }

  late final _cpBodyApplyForceAtLocalPointPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpBodyApplyForceAtLocalPoint');
  late final _cpBodyApplyForceAtLocalPoint = _cpBodyApplyForceAtLocalPointPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>();

  void cpBodyApplyImpulseAtWorldPoint(
    ffi.Pointer<cpBody> body,
    cpVect impulse,
    cpVect point,
  ) {
    return _cpBodyApplyImpulseAtWorldPoint(
      body,
      impulse,
      point,
    );
  }

  late final _cpBodyApplyImpulseAtWorldPointPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpBodyApplyImpulseAtWorldPoint');
  late final _cpBodyApplyImpulseAtWorldPoint = _cpBodyApplyImpulseAtWorldPointPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>();

  void cpBodyApplyImpulseAtLocalPoint(
    ffi.Pointer<cpBody> body,
    cpVect impulse,
    cpVect point,
  ) {
    return _cpBodyApplyImpulseAtLocalPoint(
      body,
      impulse,
      point,
    );
  }

  late final _cpBodyApplyImpulseAtLocalPointPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpBodyApplyImpulseAtLocalPoint');
  late final _cpBodyApplyImpulseAtLocalPoint = _cpBodyApplyImpulseAtLocalPointPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpVect, cpVect)>();

  cpVect cpBodyGetVelocityAtWorldPoint(
    ffi.Pointer<cpBody> body,
    cpVect point,
  ) {
    return _cpBodyGetVelocityAtWorldPoint(
      body,
      point,
    );
  }

  late final _cpBodyGetVelocityAtWorldPointPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodyGetVelocityAtWorldPoint');
  late final _cpBodyGetVelocityAtWorldPoint = _cpBodyGetVelocityAtWorldPointPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>();

  cpVect cpBodyGetVelocityAtLocalPoint(
    ffi.Pointer<cpBody> body,
    cpVect point,
  ) {
    return _cpBodyGetVelocityAtLocalPoint(
      body,
      point,
    );
  }

  late final _cpBodyGetVelocityAtLocalPointPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>>('cpBodyGetVelocityAtLocalPoint');
  late final _cpBodyGetVelocityAtLocalPoint = _cpBodyGetVelocityAtLocalPointPtr.asFunction<cpVect Function(ffi.Pointer<cpBody>, cpVect)>();

  double cpBodyKineticEnergy(
    ffi.Pointer<cpBody> body,
  ) {
    return _cpBodyKineticEnergy(
      body,
    );
  }

  late final _cpBodyKineticEnergyPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpBody>)>>('cpBodyKineticEnergy');
  late final _cpBodyKineticEnergy = _cpBodyKineticEnergyPtr.asFunction<double Function(ffi.Pointer<cpBody>)>();

  void cpBodyEachShape(
    ffi.Pointer<cpBody> body,
    cpBodyShapeIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpBodyEachShape(
      body,
      func,
      data,
      callbackId,
    );
  }

  late final _cpBodyEachShapePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpBodyShapeIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpBodyEachShape');
  late final _cpBodyEachShape = _cpBodyEachShapePtr.asFunction<void Function(ffi.Pointer<cpBody>, cpBodyShapeIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();

  void cpBodyEachConstraint(
    ffi.Pointer<cpBody> body,
    cpBodyConstraintIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpBodyEachConstraint(
      body,
      func,
      data,
      callbackId,
    );
  }

  late final _cpBodyEachConstraintPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpBodyConstraintIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpBodyEachConstraint');
  late final _cpBodyEachConstraint = _cpBodyEachConstraintPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpBodyConstraintIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();

  void cpBodyEachArbiter(
    ffi.Pointer<cpBody> body,
    cpBodyArbiterIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpBodyEachArbiter(
      body,
      func,
      data,
      callbackId,
    );
  }

  late final _cpBodyEachArbiterPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody>, cpBodyArbiterIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpBodyEachArbiter');
  late final _cpBodyEachArbiter = _cpBodyEachArbiterPtr.asFunction<void Function(ffi.Pointer<cpBody>, cpBodyArbiterIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();

  int cpConstraintIsDampedRotarySpring(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsDampedRotarySpring(
      constraint,
    );
  }

  late final _cpConstraintIsDampedRotarySpringPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsDampedRotarySpring');
  late final _cpConstraintIsDampedRotarySpring = _cpConstraintIsDampedRotarySpringPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpDampedRotarySpring> cpDampedRotarySpringAlloc() {
    return _cpDampedRotarySpringAlloc();
  }

  late final _cpDampedRotarySpringAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpDampedRotarySpring> Function()>>('cpDampedRotarySpringAlloc');
  late final _cpDampedRotarySpringAlloc = _cpDampedRotarySpringAllocPtr.asFunction<ffi.Pointer<cpDampedRotarySpring> Function()>();

  ffi.Pointer<cpDampedRotarySpring> cpDampedRotarySpringInit(
    ffi.Pointer<cpDampedRotarySpring> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double restAngle,
    double stiffness,
    double damping,
  ) {
    return _cpDampedRotarySpringInit(
      joint,
      a,
      b,
      restAngle,
      stiffness,
      damping,
    );
  }

  late final _cpDampedRotarySpringInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpDampedRotarySpring> Function(ffi.Pointer<cpDampedRotarySpring>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat, cpFloat)>>(
          'cpDampedRotarySpringInit');
  late final _cpDampedRotarySpringInit =
      _cpDampedRotarySpringInitPtr.asFunction<ffi.Pointer<cpDampedRotarySpring> Function(ffi.Pointer<cpDampedRotarySpring>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double, double)>();

  ffi.Pointer<cpConstraint> cpDampedRotarySpringNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double restAngle,
    double stiffness,
    double damping,
  ) {
    return _cpDampedRotarySpringNew(
      a,
      b,
      restAngle,
      stiffness,
      damping,
    );
  }

  late final _cpDampedRotarySpringNewPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat, cpFloat)>>('cpDampedRotarySpringNew');
  late final _cpDampedRotarySpringNew = _cpDampedRotarySpringNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double, double)>();

  double cpDampedRotarySpringGetRestAngle(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedRotarySpringGetRestAngle(
      constraint,
    );
  }

  late final _cpDampedRotarySpringGetRestAnglePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedRotarySpringGetRestAngle');
  late final _cpDampedRotarySpringGetRestAngle = _cpDampedRotarySpringGetRestAnglePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedRotarySpringSetRestAngle(
    ffi.Pointer<cpConstraint> constraint,
    double restAngle,
  ) {
    return _cpDampedRotarySpringSetRestAngle(
      constraint,
      restAngle,
    );
  }

  late final _cpDampedRotarySpringSetRestAnglePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedRotarySpringSetRestAngle');
  late final _cpDampedRotarySpringSetRestAngle = _cpDampedRotarySpringSetRestAnglePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpDampedRotarySpringGetStiffness(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedRotarySpringGetStiffness(
      constraint,
    );
  }

  late final _cpDampedRotarySpringGetStiffnessPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedRotarySpringGetStiffness');
  late final _cpDampedRotarySpringGetStiffness = _cpDampedRotarySpringGetStiffnessPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedRotarySpringSetStiffness(
    ffi.Pointer<cpConstraint> constraint,
    double stiffness,
  ) {
    return _cpDampedRotarySpringSetStiffness(
      constraint,
      stiffness,
    );
  }

  late final _cpDampedRotarySpringSetStiffnessPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedRotarySpringSetStiffness');
  late final _cpDampedRotarySpringSetStiffness = _cpDampedRotarySpringSetStiffnessPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpDampedRotarySpringGetDamping(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedRotarySpringGetDamping(
      constraint,
    );
  }

  late final _cpDampedRotarySpringGetDampingPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedRotarySpringGetDamping');
  late final _cpDampedRotarySpringGetDamping = _cpDampedRotarySpringGetDampingPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedRotarySpringSetDamping(
    ffi.Pointer<cpConstraint> constraint,
    double damping,
  ) {
    return _cpDampedRotarySpringSetDamping(
      constraint,
      damping,
    );
  }

  late final _cpDampedRotarySpringSetDampingPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedRotarySpringSetDamping');
  late final _cpDampedRotarySpringSetDamping = _cpDampedRotarySpringSetDampingPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  cpDampedRotarySpringTorqueFuncD cpDampedRotarySpringGetSpringTorqueFunc(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedRotarySpringGetSpringTorqueFunc(
      constraint,
    );
  }

  late final _cpDampedRotarySpringGetSpringTorqueFuncPtr = _lookup<ffi.NativeFunction<cpDampedRotarySpringTorqueFuncD Function(ffi.Pointer<cpConstraint>)>>('cpDampedRotarySpringGetSpringTorqueFunc');
  late final _cpDampedRotarySpringGetSpringTorqueFunc = _cpDampedRotarySpringGetSpringTorqueFuncPtr.asFunction<cpDampedRotarySpringTorqueFuncD Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedRotarySpringSetSpringTorqueFunc(
    ffi.Pointer<cpConstraint> constraint,
    cpDampedRotarySpringTorqueFuncD springTorqueFunc,
    int callbackId,
  ) {
    return _cpDampedRotarySpringSetSpringTorqueFunc(
      constraint,
      springTorqueFunc,
      callbackId,
    );
  }

  late final _cpDampedRotarySpringSetSpringTorqueFuncPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpDampedRotarySpringTorqueFuncD, ffi.Uint64)>>('cpDampedRotarySpringSetSpringTorqueFunc');
  late final _cpDampedRotarySpringSetSpringTorqueFunc = _cpDampedRotarySpringSetSpringTorqueFuncPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpDampedRotarySpringTorqueFuncD, int)>();

  void cpConstraintDestroy(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintDestroy(
      constraint,
    );
  }

  late final _cpConstraintDestroyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>)>>('cpConstraintDestroy');
  late final _cpConstraintDestroy = _cpConstraintDestroyPtr.asFunction<void Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintFree(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintFree(
      constraint,
    );
  }

  late final _cpConstraintFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>)>>('cpConstraintFree');
  late final _cpConstraintFree = _cpConstraintFreePtr.asFunction<void Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpSpace> cpConstraintGetSpace(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetSpace(
      constraint,
    );
  }

  late final _cpConstraintGetSpacePtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetSpace');
  late final _cpConstraintGetSpace = _cpConstraintGetSpacePtr.asFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpBody> cpConstraintGetBodyA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetBodyA(
      constraint,
    );
  }

  late final _cpConstraintGetBodyAPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetBodyA');
  late final _cpConstraintGetBodyA = _cpConstraintGetBodyAPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpBody> cpConstraintGetBodyB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetBodyB(
      constraint,
    );
  }

  late final _cpConstraintGetBodyBPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetBodyB');
  late final _cpConstraintGetBodyB = _cpConstraintGetBodyBPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpConstraint>)>();

  double cpConstraintGetMaxForce(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetMaxForce(
      constraint,
    );
  }

  late final _cpConstraintGetMaxForcePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetMaxForce');
  late final _cpConstraintGetMaxForce = _cpConstraintGetMaxForcePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetMaxForce(
    ffi.Pointer<cpConstraint> constraint,
    double maxForce,
  ) {
    return _cpConstraintSetMaxForce(
      constraint,
      maxForce,
    );
  }

  late final _cpConstraintSetMaxForcePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpConstraintSetMaxForce');
  late final _cpConstraintSetMaxForce = _cpConstraintSetMaxForcePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpConstraintGetErrorBias(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetErrorBias(
      constraint,
    );
  }

  late final _cpConstraintGetErrorBiasPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetErrorBias');
  late final _cpConstraintGetErrorBias = _cpConstraintGetErrorBiasPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetErrorBias(
    ffi.Pointer<cpConstraint> constraint,
    double errorBias,
  ) {
    return _cpConstraintSetErrorBias(
      constraint,
      errorBias,
    );
  }

  late final _cpConstraintSetErrorBiasPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpConstraintSetErrorBias');
  late final _cpConstraintSetErrorBias = _cpConstraintSetErrorBiasPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpConstraintGetMaxBias(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetMaxBias(
      constraint,
    );
  }

  late final _cpConstraintGetMaxBiasPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetMaxBias');
  late final _cpConstraintGetMaxBias = _cpConstraintGetMaxBiasPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetMaxBias(
    ffi.Pointer<cpConstraint> constraint,
    double maxBias,
  ) {
    return _cpConstraintSetMaxBias(
      constraint,
      maxBias,
    );
  }

  late final _cpConstraintSetMaxBiasPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpConstraintSetMaxBias');
  late final _cpConstraintSetMaxBias = _cpConstraintSetMaxBiasPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  int cpConstraintGetCollideBodies(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetCollideBodies(
      constraint,
    );
  }

  late final _cpConstraintGetCollideBodiesPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetCollideBodies');
  late final _cpConstraintGetCollideBodies = _cpConstraintGetCollideBodiesPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetCollideBodies(
    ffi.Pointer<cpConstraint> constraint,
    int collideBodies,
  ) {
    return _cpConstraintSetCollideBodies(
      constraint,
      collideBodies,
    );
  }

  late final _cpConstraintSetCollideBodiesPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpBool)>>('cpConstraintSetCollideBodies');
  late final _cpConstraintSetCollideBodies = _cpConstraintSetCollideBodiesPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, int)>();

  cpConstraintPreSolveFuncD cpConstraintGetPreSolveFunc(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetPreSolveFunc(
      constraint,
    );
  }

  late final _cpConstraintGetPreSolveFuncPtr = _lookup<ffi.NativeFunction<cpConstraintPreSolveFuncD Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetPreSolveFunc');
  late final _cpConstraintGetPreSolveFunc = _cpConstraintGetPreSolveFuncPtr.asFunction<cpConstraintPreSolveFuncD Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetPreSolveFunc(
    ffi.Pointer<cpConstraint> constraint,
    cpConstraintPreSolveFuncD preSolveFunc,
  ) {
    return _cpConstraintSetPreSolveFunc(
      constraint,
      preSolveFunc,
    );
  }

  late final _cpConstraintSetPreSolveFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpConstraintPreSolveFuncD)>>('cpConstraintSetPreSolveFunc');
  late final _cpConstraintSetPreSolveFunc = _cpConstraintSetPreSolveFuncPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpConstraintPreSolveFuncD)>();
  cpConstraintPostSolveFuncD cpConstraintGetPostSolveFunc(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetPostSolveFunc(
      constraint,
    );
  }

  late final _cpConstraintGetPostSolveFuncPtr = _lookup<ffi.NativeFunction<cpConstraintPostSolveFuncD Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetPostSolveFunc');
  late final _cpConstraintGetPostSolveFunc = _cpConstraintGetPostSolveFuncPtr.asFunction<cpConstraintPostSolveFuncD Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetPostSolveFunc(
    ffi.Pointer<cpConstraint> constraint,
    cpConstraintPostSolveFuncD postSolveFunc,
    int callbackId,
  ) {
    return _cpConstraintSetPostSolveFunc(
      constraint,
      postSolveFunc,
      callbackId,
    );
  }

  late final _cpConstraintSetPostSolveFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpConstraintPostSolveFuncD, ffi.Uint64)>>('cpConstraintSetPostSolveFunc');
  late final _cpConstraintSetPostSolveFunc = _cpConstraintSetPostSolveFuncPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpConstraintPostSolveFuncD, int)>();

  cpDataPointer cpConstraintGetUserData(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetUserData(
      constraint,
    );
  }

  late final _cpConstraintGetUserDataPtr = _lookup<ffi.NativeFunction<cpDataPointer Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetUserData');
  late final _cpConstraintGetUserData = _cpConstraintGetUserDataPtr.asFunction<cpDataPointer Function(ffi.Pointer<cpConstraint>)>();

  void cpConstraintSetUserData(
    ffi.Pointer<cpConstraint> constraint,
    cpDataPointer userData,
  ) {
    return _cpConstraintSetUserData(
      constraint,
      userData,
    );
  }

  late final _cpConstraintSetUserDataPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpDataPointer)>>('cpConstraintSetUserData');
  late final _cpConstraintSetUserData = _cpConstraintSetUserDataPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpDataPointer)>();

  double cpConstraintGetImpulse(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintGetImpulse(
      constraint,
    );
  }

  late final _cpConstraintGetImpulsePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpConstraintGetImpulse');
  late final _cpConstraintGetImpulse = _cpConstraintGetImpulsePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  int cpConstraintIsGearJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsGearJoint(
      constraint,
    );
  }

  late final _cpConstraintIsGearJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsGearJoint');
  late final _cpConstraintIsGearJoint = _cpConstraintIsGearJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpGearJoint> cpGearJointAlloc() {
    return _cpGearJointAlloc();
  }

  late final _cpGearJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpGearJoint> Function()>>('cpGearJointAlloc');
  late final _cpGearJointAlloc = _cpGearJointAllocPtr.asFunction<ffi.Pointer<cpGearJoint> Function()>();

  ffi.Pointer<cpGearJoint> cpGearJointInit(
    ffi.Pointer<cpGearJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double phase,
    double ratio,
  ) {
    return _cpGearJointInit(
      joint,
      a,
      b,
      phase,
      ratio,
    );
  }

  late final _cpGearJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpGearJoint> Function(ffi.Pointer<cpGearJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpGearJointInit');
  late final _cpGearJointInit = _cpGearJointInitPtr.asFunction<ffi.Pointer<cpGearJoint> Function(ffi.Pointer<cpGearJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  ffi.Pointer<cpConstraint> cpGearJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double phase,
    double ratio,
  ) {
    return _cpGearJointNew(
      a,
      b,
      phase,
      ratio,
    );
  }

  late final _cpGearJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpGearJointNew');
  late final _cpGearJointNew = _cpGearJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  double cpGearJointGetPhase(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpGearJointGetPhase(
      constraint,
    );
  }

  late final _cpGearJointGetPhasePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpGearJointGetPhase');
  late final _cpGearJointGetPhase = _cpGearJointGetPhasePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpGearJointSetPhase(
    ffi.Pointer<cpConstraint> constraint,
    double phase,
  ) {
    return _cpGearJointSetPhase(
      constraint,
      phase,
    );
  }

  late final _cpGearJointSetPhasePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpGearJointSetPhase');
  late final _cpGearJointSetPhase = _cpGearJointSetPhasePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpGearJointGetRatio(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpGearJointGetRatio(
      constraint,
    );
  }

  late final _cpGearJointGetRatioPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpGearJointGetRatio');
  late final _cpGearJointGetRatio = _cpGearJointGetRatioPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpGearJointSetRatio(
    ffi.Pointer<cpConstraint> constraint,
    double ratio,
  ) {
    return _cpGearJointSetRatio(
      constraint,
      ratio,
    );
  }

  late final _cpGearJointSetRatioPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpGearJointSetRatio');
  late final _cpGearJointSetRatio = _cpGearJointSetRatioPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  int cpConstraintIsDampedSpring(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsDampedSpring(
      constraint,
    );
  }

  late final _cpConstraintIsDampedSpringPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsDampedSpring');
  late final _cpConstraintIsDampedSpring = _cpConstraintIsDampedSpringPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpDampedSpring> cpDampedSpringAlloc() {
    return _cpDampedSpringAlloc();
  }

  late final _cpDampedSpringAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpDampedSpring> Function()>>('cpDampedSpringAlloc');
  late final _cpDampedSpringAlloc = _cpDampedSpringAllocPtr.asFunction<ffi.Pointer<cpDampedSpring> Function()>();

  ffi.Pointer<cpDampedSpring> cpDampedSpringInit(
    ffi.Pointer<cpDampedSpring> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
    double restLength,
    double stiffness,
    double damping,
  ) {
    return _cpDampedSpringInit(
      joint,
      a,
      b,
      anchorA,
      anchorB,
      restLength,
      stiffness,
      damping,
    );
  }

  late final _cpDampedSpringInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpDampedSpring> Function(ffi.Pointer<cpDampedSpring>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat, cpFloat, cpFloat)>>(
          'cpDampedSpringInit');
  late final _cpDampedSpringInit =
      _cpDampedSpringInitPtr.asFunction<ffi.Pointer<cpDampedSpring> Function(ffi.Pointer<cpDampedSpring>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, double, double, double)>();

  ffi.Pointer<cpConstraint> cpDampedSpringNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
    double restLength,
    double stiffness,
    double damping,
  ) {
    return _cpDampedSpringNew(
      a,
      b,
      anchorA,
      anchorB,
      restLength,
      stiffness,
      damping,
    );
  }

  late final _cpDampedSpringNewPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat, cpFloat, cpFloat)>>('cpDampedSpringNew');
  late final _cpDampedSpringNew = _cpDampedSpringNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, double, double, double)>();

  cpVect cpDampedSpringGetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetAnchorA(
      constraint,
    );
  }

  late final _cpDampedSpringGetAnchorAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetAnchorA');
  late final _cpDampedSpringGetAnchorA = _cpDampedSpringGetAnchorAPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorA,
  ) {
    return _cpDampedSpringSetAnchorA(
      constraint,
      anchorA,
    );
  }

  late final _cpDampedSpringSetAnchorAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpDampedSpringSetAnchorA');
  late final _cpDampedSpringSetAnchorA = _cpDampedSpringSetAnchorAPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpDampedSpringGetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetAnchorB(
      constraint,
    );
  }

  late final _cpDampedSpringGetAnchorBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetAnchorB');
  late final _cpDampedSpringGetAnchorB = _cpDampedSpringGetAnchorBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorB,
  ) {
    return _cpDampedSpringSetAnchorB(
      constraint,
      anchorB,
    );
  }

  late final _cpDampedSpringSetAnchorBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpDampedSpringSetAnchorB');
  late final _cpDampedSpringSetAnchorB = _cpDampedSpringSetAnchorBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  double cpDampedSpringGetRestLength(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetRestLength(
      constraint,
    );
  }

  late final _cpDampedSpringGetRestLengthPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetRestLength');
  late final _cpDampedSpringGetRestLength = _cpDampedSpringGetRestLengthPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetRestLength(
    ffi.Pointer<cpConstraint> constraint,
    double restLength,
  ) {
    return _cpDampedSpringSetRestLength(
      constraint,
      restLength,
    );
  }

  late final _cpDampedSpringSetRestLengthPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedSpringSetRestLength');
  late final _cpDampedSpringSetRestLength = _cpDampedSpringSetRestLengthPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpDampedSpringGetStiffness(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetStiffness(
      constraint,
    );
  }

  late final _cpDampedSpringGetStiffnessPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetStiffness');
  late final _cpDampedSpringGetStiffness = _cpDampedSpringGetStiffnessPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetStiffness(
    ffi.Pointer<cpConstraint> constraint,
    double stiffness,
  ) {
    return _cpDampedSpringSetStiffness(
      constraint,
      stiffness,
    );
  }

  late final _cpDampedSpringSetStiffnessPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedSpringSetStiffness');
  late final _cpDampedSpringSetStiffness = _cpDampedSpringSetStiffnessPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpDampedSpringGetDamping(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetDamping(
      constraint,
    );
  }

  late final _cpDampedSpringGetDampingPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetDamping');
  late final _cpDampedSpringGetDamping = _cpDampedSpringGetDampingPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetDamping(
    ffi.Pointer<cpConstraint> constraint,
    double damping,
  ) {
    return _cpDampedSpringSetDamping(
      constraint,
      damping,
    );
  }

  late final _cpDampedSpringSetDampingPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpDampedSpringSetDamping');
  late final _cpDampedSpringSetDamping = _cpDampedSpringSetDampingPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  cpDampedSpringForceFuncD cpDampedSpringGetSpringForceFunc(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpDampedSpringGetSpringForceFunc(
      constraint,
    );
  }

  late final _cpDampedSpringGetSpringForceFuncPtr = _lookup<ffi.NativeFunction<cpDampedSpringForceFuncD Function(ffi.Pointer<cpConstraint>)>>('cpDampedSpringGetSpringForceFunc');
  late final _cpDampedSpringGetSpringForceFunc = _cpDampedSpringGetSpringForceFuncPtr.asFunction<cpDampedSpringForceFuncD Function(ffi.Pointer<cpConstraint>)>();

  void cpDampedSpringSetSpringForceFunc(
    ffi.Pointer<cpConstraint> constraint,
    cpDampedSpringForceFuncD springForceFunc,
    int callbackId,
  ) {
    return _cpDampedSpringSetSpringForceFunc(
      constraint,
      springForceFunc,
      callbackId,
    );
  }

  late final _cpDampedSpringSetSpringForceFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpDampedSpringForceFuncD, ffi.Uint64)>>('cpDampedSpringSetSpringForceFunc');
  late final _cpDampedSpringSetSpringForceFunc = _cpDampedSpringSetSpringForceFuncPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpDampedSpringForceFuncD, int)>();

  int cpConstraintIsPivotJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsPivotJoint(
      constraint,
    );
  }

  late final _cpConstraintIsPivotJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsPivotJoint');
  late final _cpConstraintIsPivotJoint = _cpConstraintIsPivotJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpPivotJoint> cpPivotJointAlloc() {
    return _cpPivotJointAlloc();
  }

  late final _cpPivotJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPivotJoint> Function()>>('cpPivotJointAlloc');
  late final _cpPivotJointAlloc = _cpPivotJointAllocPtr.asFunction<ffi.Pointer<cpPivotJoint> Function()>();

  ffi.Pointer<cpPivotJoint> cpPivotJointInit(
    ffi.Pointer<cpPivotJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
  ) {
    return _cpPivotJointInit(
      joint,
      a,
      b,
      anchorA,
      anchorB,
    );
  }

  late final _cpPivotJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpPivotJoint> Function(ffi.Pointer<cpPivotJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpPivotJointInit');
  late final _cpPivotJointInit = _cpPivotJointInitPtr.asFunction<ffi.Pointer<cpPivotJoint> Function(ffi.Pointer<cpPivotJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>();

  ffi.Pointer<cpConstraint> cpPivotJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect pivot,
  ) {
    return _cpPivotJointNew(
      a,
      b,
      pivot,
    );
  }

  late final _cpPivotJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect)>>('cpPivotJointNew');
  late final _cpPivotJointNew = _cpPivotJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect)>();

  ffi.Pointer<cpConstraint> cpPivotJointNew2(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
  ) {
    return _cpPivotJointNew2(
      a,
      b,
      anchorA,
      anchorB,
    );
  }

  late final _cpPivotJointNew2Ptr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpPivotJointNew2');
  late final _cpPivotJointNew2 = _cpPivotJointNew2Ptr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>();

  cpVect cpPivotJointGetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpPivotJointGetAnchorA(
      constraint,
    );
  }

  late final _cpPivotJointGetAnchorAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpPivotJointGetAnchorA');
  late final _cpPivotJointGetAnchorA = _cpPivotJointGetAnchorAPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpPivotJointSetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorA,
  ) {
    return _cpPivotJointSetAnchorA(
      constraint,
      anchorA,
    );
  }

  late final _cpPivotJointSetAnchorAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpPivotJointSetAnchorA');
  late final _cpPivotJointSetAnchorA = _cpPivotJointSetAnchorAPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpPivotJointGetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpPivotJointGetAnchorB(
      constraint,
    );
  }

  late final _cpPivotJointGetAnchorBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpPivotJointGetAnchorB');
  late final _cpPivotJointGetAnchorB = _cpPivotJointGetAnchorBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpPivotJointSetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorB,
  ) {
    return _cpPivotJointSetAnchorB(
      constraint,
      anchorB,
    );
  }

  late final _cpPivotJointSetAnchorBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpPivotJointSetAnchorB');
  late final _cpPivotJointSetAnchorB = _cpPivotJointSetAnchorBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  int cpConstraintIsPinJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsPinJoint(
      constraint,
    );
  }

  late final _cpConstraintIsPinJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsPinJoint');
  late final _cpConstraintIsPinJoint = _cpConstraintIsPinJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpPinJoint> cpPinJointAlloc() {
    return _cpPinJointAlloc();
  }

  late final _cpPinJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPinJoint> Function()>>('cpPinJointAlloc');
  late final _cpPinJointAlloc = _cpPinJointAllocPtr.asFunction<ffi.Pointer<cpPinJoint> Function()>();

  ffi.Pointer<cpPinJoint> cpPinJointInit(
    ffi.Pointer<cpPinJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
  ) {
    return _cpPinJointInit(
      joint,
      a,
      b,
      anchorA,
      anchorB,
    );
  }

  late final _cpPinJointInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPinJoint> Function(ffi.Pointer<cpPinJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpPinJointInit');
  late final _cpPinJointInit = _cpPinJointInitPtr.asFunction<ffi.Pointer<cpPinJoint> Function(ffi.Pointer<cpPinJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>();

  ffi.Pointer<cpConstraint> cpPinJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
  ) {
    return _cpPinJointNew(
      a,
      b,
      anchorA,
      anchorB,
    );
  }

  late final _cpPinJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>>('cpPinJointNew');
  late final _cpPinJointNew = _cpPinJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect)>();

  cpVect cpPinJointGetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpPinJointGetAnchorA(
      constraint,
    );
  }

  late final _cpPinJointGetAnchorAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpPinJointGetAnchorA');
  late final _cpPinJointGetAnchorA = _cpPinJointGetAnchorAPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpPinJointSetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorA,
  ) {
    return _cpPinJointSetAnchorA(
      constraint,
      anchorA,
    );
  }

  late final _cpPinJointSetAnchorAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpPinJointSetAnchorA');
  late final _cpPinJointSetAnchorA = _cpPinJointSetAnchorAPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpPinJointGetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpPinJointGetAnchorB(
      constraint,
    );
  }

  late final _cpPinJointGetAnchorBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpPinJointGetAnchorB');
  late final _cpPinJointGetAnchorB = _cpPinJointGetAnchorBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpPinJointSetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorB,
  ) {
    return _cpPinJointSetAnchorB(
      constraint,
      anchorB,
    );
  }

  late final _cpPinJointSetAnchorBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpPinJointSetAnchorB');
  late final _cpPinJointSetAnchorB = _cpPinJointSetAnchorBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  double cpPinJointGetDist(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpPinJointGetDist(
      constraint,
    );
  }

  late final _cpPinJointGetDistPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpPinJointGetDist');
  late final _cpPinJointGetDist = _cpPinJointGetDistPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpPinJointSetDist(
    ffi.Pointer<cpConstraint> constraint,
    double dist,
  ) {
    return _cpPinJointSetDist(
      constraint,
      dist,
    );
  }

  late final _cpPinJointSetDistPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpPinJointSetDist');
  late final _cpPinJointSetDist = _cpPinJointSetDistPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  int cpConstraintIsGrooveJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsGrooveJoint(
      constraint,
    );
  }

  late final _cpConstraintIsGrooveJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsGrooveJoint');
  late final _cpConstraintIsGrooveJoint = _cpConstraintIsGrooveJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpGrooveJoint> cpGrooveJointAlloc() {
    return _cpGrooveJointAlloc();
  }

  late final _cpGrooveJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpGrooveJoint> Function()>>('cpGrooveJointAlloc');
  late final _cpGrooveJointAlloc = _cpGrooveJointAllocPtr.asFunction<ffi.Pointer<cpGrooveJoint> Function()>();

  ffi.Pointer<cpGrooveJoint> cpGrooveJointInit(
    ffi.Pointer<cpGrooveJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect groove_a,
    cpVect groove_b,
    cpVect anchorB,
  ) {
    return _cpGrooveJointInit(
      joint,
      a,
      b,
      groove_a,
      groove_b,
      anchorB,
    );
  }

  late final _cpGrooveJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpGrooveJoint> Function(ffi.Pointer<cpGrooveJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpVect)>>('cpGrooveJointInit');
  late final _cpGrooveJointInit = _cpGrooveJointInitPtr.asFunction<ffi.Pointer<cpGrooveJoint> Function(ffi.Pointer<cpGrooveJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpVect)>();

  ffi.Pointer<cpConstraint> cpGrooveJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect groove_a,
    cpVect groove_b,
    cpVect anchorB,
  ) {
    return _cpGrooveJointNew(
      a,
      b,
      groove_a,
      groove_b,
      anchorB,
    );
  }

  late final _cpGrooveJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpVect)>>('cpGrooveJointNew');
  late final _cpGrooveJointNew = _cpGrooveJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpVect)>();

  cpVect cpGrooveJointGetGrooveA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpGrooveJointGetGrooveA(
      constraint,
    );
  }

  late final _cpGrooveJointGetGrooveAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpGrooveJointGetGrooveA');
  late final _cpGrooveJointGetGrooveA = _cpGrooveJointGetGrooveAPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpGrooveJointSetGrooveA(
    ffi.Pointer<cpConstraint> constraint,
    cpVect grooveA,
  ) {
    return _cpGrooveJointSetGrooveA(
      constraint,
      grooveA,
    );
  }

  late final _cpGrooveJointSetGrooveAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpGrooveJointSetGrooveA');
  late final _cpGrooveJointSetGrooveA = _cpGrooveJointSetGrooveAPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpGrooveJointGetGrooveB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpGrooveJointGetGrooveB(
      constraint,
    );
  }

  late final _cpGrooveJointGetGrooveBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpGrooveJointGetGrooveB');
  late final _cpGrooveJointGetGrooveB = _cpGrooveJointGetGrooveBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpGrooveJointSetGrooveB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect grooveB,
  ) {
    return _cpGrooveJointSetGrooveB(
      constraint,
      grooveB,
    );
  }

  late final _cpGrooveJointSetGrooveBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpGrooveJointSetGrooveB');
  late final _cpGrooveJointSetGrooveB = _cpGrooveJointSetGrooveBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpGrooveJointGetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpGrooveJointGetAnchorB(
      constraint,
    );
  }

  late final _cpGrooveJointGetAnchorBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpGrooveJointGetAnchorB');
  late final _cpGrooveJointGetAnchorB = _cpGrooveJointGetAnchorBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpGrooveJointSetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorB,
  ) {
    return _cpGrooveJointSetAnchorB(
      constraint,
      anchorB,
    );
  }

  late final _cpGrooveJointSetAnchorBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpGrooveJointSetAnchorB');
  late final _cpGrooveJointSetAnchorB = _cpGrooveJointSetAnchorBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  ffi.Pointer<cpPolyShape> cpPolyShapeAlloc() {
    return _cpPolyShapeAlloc();
  }

  late final _cpPolyShapeAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyShape> Function()>>('cpPolyShapeAlloc');
  late final _cpPolyShapeAlloc = _cpPolyShapeAllocPtr.asFunction<ffi.Pointer<cpPolyShape> Function()>();

  ffi.Pointer<cpPolyShape> cpPolyShapeInit(
    ffi.Pointer<cpPolyShape> poly,
    ffi.Pointer<cpBody> body,
    int count,
    ffi.Pointer<cpVect> verts,
    cpTransform transform,
    double radius,
  ) {
    return _cpPolyShapeInit(
      poly,
      body,
      count,
      verts,
      transform,
      radius,
    );
  }

  late final _cpPolyShapeInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, ffi.Int, ffi.Pointer<cpVect>, cpTransform, cpFloat)>>('cpPolyShapeInit');
  late final _cpPolyShapeInit = _cpPolyShapeInitPtr.asFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, int, ffi.Pointer<cpVect>, cpTransform, double)>();

  ffi.Pointer<cpPolyShape> cpPolyShapeInitRaw(
    ffi.Pointer<cpPolyShape> poly,
    ffi.Pointer<cpBody> body,
    int count,
    ffi.Pointer<cpVect> verts,
    double radius,
  ) {
    return _cpPolyShapeInitRaw(
      poly,
      body,
      count,
      verts,
      radius,
    );
  }

  late final _cpPolyShapeInitRawPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, ffi.Int, ffi.Pointer<cpVect>, cpFloat)>>('cpPolyShapeInitRaw');
  late final _cpPolyShapeInitRaw = _cpPolyShapeInitRawPtr.asFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, int, ffi.Pointer<cpVect>, double)>();

  ffi.Pointer<cpShape> cpPolyShapeNew(
    ffi.Pointer<cpBody> body,
    int count,
    ffi.Pointer<cpVect> verts,
    cpTransform transform,
    double radius,
  ) {
    return _cpPolyShapeNew(
      body,
      count,
      verts,
      transform,
      radius,
    );
  }

  late final _cpPolyShapeNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, ffi.Int, ffi.Pointer<cpVect>, cpTransform, cpFloat)>>('cpPolyShapeNew');
  late final _cpPolyShapeNew = _cpPolyShapeNewPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, int, ffi.Pointer<cpVect>, cpTransform, double)>();

  ffi.Pointer<cpShape> cpPolyShapeNewRaw(
    ffi.Pointer<cpBody> body,
    int count,
    ffi.Pointer<cpVect> verts,
    double radius,
  ) {
    return _cpPolyShapeNewRaw(
      body,
      count,
      verts,
      radius,
    );
  }

  late final _cpPolyShapeNewRawPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, ffi.Int, ffi.Pointer<cpVect>, cpFloat)>>('cpPolyShapeNewRaw');
  late final _cpPolyShapeNewRaw = _cpPolyShapeNewRawPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, int, ffi.Pointer<cpVect>, double)>();

  ffi.Pointer<cpPolyShape> cpBoxShapeInit(
    ffi.Pointer<cpPolyShape> poly,
    ffi.Pointer<cpBody> body,
    double width,
    double height,
    double radius,
  ) {
    return _cpBoxShapeInit(
      poly,
      body,
      width,
      height,
      radius,
    );
  }

  late final _cpBoxShapeInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, cpFloat, cpFloat, cpFloat)>>('cpBoxShapeInit');
  late final _cpBoxShapeInit = _cpBoxShapeInitPtr.asFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, double, double, double)>();

  ffi.Pointer<cpPolyShape> cpBoxShapeInit2(
    ffi.Pointer<cpPolyShape> poly,
    ffi.Pointer<cpBody> body,
    cpBB box,
    double radius,
  ) {
    return _cpBoxShapeInit2(
      poly,
      body,
      box,
      radius,
    );
  }

  late final _cpBoxShapeInit2Ptr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, cpBB, cpFloat)>>('cpBoxShapeInit2');
  late final _cpBoxShapeInit2 = _cpBoxShapeInit2Ptr.asFunction<ffi.Pointer<cpPolyShape> Function(ffi.Pointer<cpPolyShape>, ffi.Pointer<cpBody>, cpBB, double)>();

  ffi.Pointer<cpShape> cpBoxShapeNew(
    ffi.Pointer<cpBody> body,
    double width,
    double height,
    double radius,
  ) {
    return _cpBoxShapeNew(
      body,
      width,
      height,
      radius,
    );
  }

  late final _cpBoxShapeNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpFloat, cpFloat, cpFloat)>>('cpBoxShapeNew');
  late final _cpBoxShapeNew = _cpBoxShapeNewPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, double, double, double)>();

  ffi.Pointer<cpShape> cpBoxShapeNew2(
    ffi.Pointer<cpBody> body,
    cpBB box,
    double radius,
  ) {
    return _cpBoxShapeNew2(
      body,
      box,
      radius,
    );
  }

  late final _cpBoxShapeNew2Ptr = _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpBB, cpFloat)>>('cpBoxShapeNew2');
  late final _cpBoxShapeNew2 = _cpBoxShapeNew2Ptr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpBody>, cpBB, double)>();

  int cpPolyShapeGetCount(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpPolyShapeGetCount(
      shape,
    );
  }

  late final _cpPolyShapeGetCountPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<cpShape>)>>('cpPolyShapeGetCount');
  late final _cpPolyShapeGetCount = _cpPolyShapeGetCountPtr.asFunction<int Function(ffi.Pointer<cpShape>)>();

  cpVect cpPolyShapeGetVert(
    ffi.Pointer<cpShape> shape,
    int index,
  ) {
    return _cpPolyShapeGetVert(
      shape,
      index,
    );
  }

  late final _cpPolyShapeGetVertPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>, ffi.Int)>>('cpPolyShapeGetVert');
  late final _cpPolyShapeGetVert = _cpPolyShapeGetVertPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>, int)>();

  double cpPolyShapeGetRadius(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpPolyShapeGetRadius(
      shape,
    );
  }

  late final _cpPolyShapeGetRadiusPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpPolyShapeGetRadius');
  late final _cpPolyShapeGetRadius = _cpPolyShapeGetRadiusPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  int cpConstraintIsRotaryLimitJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsRotaryLimitJoint(
      constraint,
    );
  }

  late final _cpConstraintIsRotaryLimitJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsRotaryLimitJoint');
  late final _cpConstraintIsRotaryLimitJoint = _cpConstraintIsRotaryLimitJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpRotaryLimitJoint> cpRotaryLimitJointAlloc() {
    return _cpRotaryLimitJointAlloc();
  }

  late final _cpRotaryLimitJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpRotaryLimitJoint> Function()>>('cpRotaryLimitJointAlloc');
  late final _cpRotaryLimitJointAlloc = _cpRotaryLimitJointAllocPtr.asFunction<ffi.Pointer<cpRotaryLimitJoint> Function()>();

  ffi.Pointer<cpRotaryLimitJoint> cpRotaryLimitJointInit(
    ffi.Pointer<cpRotaryLimitJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double min,
    double max,
  ) {
    return _cpRotaryLimitJointInit(
      joint,
      a,
      b,
      min,
      max,
    );
  }

  late final _cpRotaryLimitJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpRotaryLimitJoint> Function(ffi.Pointer<cpRotaryLimitJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpRotaryLimitJointInit');
  late final _cpRotaryLimitJointInit =
      _cpRotaryLimitJointInitPtr.asFunction<ffi.Pointer<cpRotaryLimitJoint> Function(ffi.Pointer<cpRotaryLimitJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  ffi.Pointer<cpConstraint> cpRotaryLimitJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double min,
    double max,
  ) {
    return _cpRotaryLimitJointNew(
      a,
      b,
      min,
      max,
    );
  }

  late final _cpRotaryLimitJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpRotaryLimitJointNew');
  late final _cpRotaryLimitJointNew = _cpRotaryLimitJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  double cpRotaryLimitJointGetMin(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpRotaryLimitJointGetMin(
      constraint,
    );
  }

  late final _cpRotaryLimitJointGetMinPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpRotaryLimitJointGetMin');
  late final _cpRotaryLimitJointGetMin = _cpRotaryLimitJointGetMinPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpRotaryLimitJointSetMin(
    ffi.Pointer<cpConstraint> constraint,
    double min,
  ) {
    return _cpRotaryLimitJointSetMin(
      constraint,
      min,
    );
  }

  late final _cpRotaryLimitJointSetMinPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpRotaryLimitJointSetMin');
  late final _cpRotaryLimitJointSetMin = _cpRotaryLimitJointSetMinPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpRotaryLimitJointGetMax(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpRotaryLimitJointGetMax(
      constraint,
    );
  }

  late final _cpRotaryLimitJointGetMaxPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpRotaryLimitJointGetMax');
  late final _cpRotaryLimitJointGetMax = _cpRotaryLimitJointGetMaxPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpRotaryLimitJointSetMax(
    ffi.Pointer<cpConstraint> constraint,
    double max,
  ) {
    return _cpRotaryLimitJointSetMax(
      constraint,
      max,
    );
  }

  late final _cpRotaryLimitJointSetMaxPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpRotaryLimitJointSetMax');
  late final _cpRotaryLimitJointSetMax = _cpRotaryLimitJointSetMaxPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  int cpConstraintIsRatchetJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsRatchetJoint(
      constraint,
    );
  }

  late final _cpConstraintIsRatchetJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsRatchetJoint');
  late final _cpConstraintIsRatchetJoint = _cpConstraintIsRatchetJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpRatchetJoint> cpRatchetJointAlloc() {
    return _cpRatchetJointAlloc();
  }

  late final _cpRatchetJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpRatchetJoint> Function()>>('cpRatchetJointAlloc');
  late final _cpRatchetJointAlloc = _cpRatchetJointAllocPtr.asFunction<ffi.Pointer<cpRatchetJoint> Function()>();

  ffi.Pointer<cpRatchetJoint> cpRatchetJointInit(
    ffi.Pointer<cpRatchetJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double phase,
    double ratchet,
  ) {
    return _cpRatchetJointInit(
      joint,
      a,
      b,
      phase,
      ratchet,
    );
  }

  late final _cpRatchetJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpRatchetJoint> Function(ffi.Pointer<cpRatchetJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpRatchetJointInit');
  late final _cpRatchetJointInit = _cpRatchetJointInitPtr.asFunction<ffi.Pointer<cpRatchetJoint> Function(ffi.Pointer<cpRatchetJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  ffi.Pointer<cpConstraint> cpRatchetJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double phase,
    double ratchet,
  ) {
    return _cpRatchetJointNew(
      a,
      b,
      phase,
      ratchet,
    );
  }

  late final _cpRatchetJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat, cpFloat)>>('cpRatchetJointNew');
  late final _cpRatchetJointNew = _cpRatchetJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double, double)>();

  double cpRatchetJointGetAngle(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpRatchetJointGetAngle(
      constraint,
    );
  }

  late final _cpRatchetJointGetAnglePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpRatchetJointGetAngle');
  late final _cpRatchetJointGetAngle = _cpRatchetJointGetAnglePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpRatchetJointSetAngle(
    ffi.Pointer<cpConstraint> constraint,
    double angle,
  ) {
    return _cpRatchetJointSetAngle(
      constraint,
      angle,
    );
  }

  late final _cpRatchetJointSetAnglePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpRatchetJointSetAngle');
  late final _cpRatchetJointSetAngle = _cpRatchetJointSetAnglePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpRatchetJointGetPhase(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpRatchetJointGetPhase(
      constraint,
    );
  }

  late final _cpRatchetJointGetPhasePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpRatchetJointGetPhase');
  late final _cpRatchetJointGetPhase = _cpRatchetJointGetPhasePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpRatchetJointSetPhase(
    ffi.Pointer<cpConstraint> constraint,
    double phase,
  ) {
    return _cpRatchetJointSetPhase(
      constraint,
      phase,
    );
  }

  late final _cpRatchetJointSetPhasePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpRatchetJointSetPhase');
  late final _cpRatchetJointSetPhase = _cpRatchetJointSetPhasePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpRatchetJointGetRatchet(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpRatchetJointGetRatchet(
      constraint,
    );
  }

  late final _cpRatchetJointGetRatchetPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpRatchetJointGetRatchet');
  late final _cpRatchetJointGetRatchet = _cpRatchetJointGetRatchetPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpRatchetJointSetRatchet(
    ffi.Pointer<cpConstraint> constraint,
    double ratchet,
  ) {
    return _cpRatchetJointSetRatchet(
      constraint,
      ratchet,
    );
  }

  late final _cpRatchetJointSetRatchetPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpRatchetJointSetRatchet');
  late final _cpRatchetJointSetRatchet = _cpRatchetJointSetRatchetPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  int cpConstraintIsSlideJoint(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsSlideJoint(
      constraint,
    );
  }

  late final _cpConstraintIsSlideJointPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsSlideJoint');
  late final _cpConstraintIsSlideJoint = _cpConstraintIsSlideJointPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpSlideJoint> cpSlideJointAlloc() {
    return _cpSlideJointAlloc();
  }

  late final _cpSlideJointAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSlideJoint> Function()>>('cpSlideJointAlloc');
  late final _cpSlideJointAlloc = _cpSlideJointAllocPtr.asFunction<ffi.Pointer<cpSlideJoint> Function()>();

  ffi.Pointer<cpSlideJoint> cpSlideJointInit(
    ffi.Pointer<cpSlideJoint> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
    double min,
    double max,
  ) {
    return _cpSlideJointInit(
      joint,
      a,
      b,
      anchorA,
      anchorB,
      min,
      max,
    );
  }

  late final _cpSlideJointInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpSlideJoint> Function(ffi.Pointer<cpSlideJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat, cpFloat)>>('cpSlideJointInit');
  late final _cpSlideJointInit =
      _cpSlideJointInitPtr.asFunction<ffi.Pointer<cpSlideJoint> Function(ffi.Pointer<cpSlideJoint>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, double, double)>();

  ffi.Pointer<cpConstraint> cpSlideJointNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    cpVect anchorA,
    cpVect anchorB,
    double min,
    double max,
  ) {
    return _cpSlideJointNew(
      a,
      b,
      anchorA,
      anchorB,
      min,
      max,
    );
  }

  late final _cpSlideJointNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat, cpFloat)>>('cpSlideJointNew');
  late final _cpSlideJointNew = _cpSlideJointNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpVect, cpVect, double, double)>();

  cpVect cpSlideJointGetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSlideJointGetAnchorA(
      constraint,
    );
  }

  late final _cpSlideJointGetAnchorAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpSlideJointGetAnchorA');
  late final _cpSlideJointGetAnchorA = _cpSlideJointGetAnchorAPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpSlideJointSetAnchorA(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorA,
  ) {
    return _cpSlideJointSetAnchorA(
      constraint,
      anchorA,
    );
  }

  late final _cpSlideJointSetAnchorAPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpSlideJointSetAnchorA');
  late final _cpSlideJointSetAnchorA = _cpSlideJointSetAnchorAPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  cpVect cpSlideJointGetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSlideJointGetAnchorB(
      constraint,
    );
  }

  late final _cpSlideJointGetAnchorBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpConstraint>)>>('cpSlideJointGetAnchorB');
  late final _cpSlideJointGetAnchorB = _cpSlideJointGetAnchorBPtr.asFunction<cpVect Function(ffi.Pointer<cpConstraint>)>();

  void cpSlideJointSetAnchorB(
    ffi.Pointer<cpConstraint> constraint,
    cpVect anchorB,
  ) {
    return _cpSlideJointSetAnchorB(
      constraint,
      anchorB,
    );
  }

  late final _cpSlideJointSetAnchorBPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpVect)>>('cpSlideJointSetAnchorB');
  late final _cpSlideJointSetAnchorB = _cpSlideJointSetAnchorBPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, cpVect)>();

  double cpSlideJointGetMin(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSlideJointGetMin(
      constraint,
    );
  }

  late final _cpSlideJointGetMinPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpSlideJointGetMin');
  late final _cpSlideJointGetMin = _cpSlideJointGetMinPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpSlideJointSetMin(
    ffi.Pointer<cpConstraint> constraint,
    double min,
  ) {
    return _cpSlideJointSetMin(
      constraint,
      min,
    );
  }

  late final _cpSlideJointSetMinPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpSlideJointSetMin');
  late final _cpSlideJointSetMin = _cpSlideJointSetMinPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  double cpSlideJointGetMax(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSlideJointGetMax(
      constraint,
    );
  }

  late final _cpSlideJointGetMaxPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpSlideJointGetMax');
  late final _cpSlideJointGetMax = _cpSlideJointGetMaxPtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpSlideJointSetMax(
    ffi.Pointer<cpConstraint> constraint,
    double max,
  ) {
    return _cpSlideJointSetMax(
      constraint,
      max,
    );
  }

  late final _cpSlideJointSetMaxPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpSlideJointSetMax');
  late final _cpSlideJointSetMax = _cpSlideJointSetMaxPtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  void cpShapeDestroy(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeDestroy(
      shape,
    );
  }

  late final _cpShapeDestroyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>)>>('cpShapeDestroy');
  late final _cpShapeDestroy = _cpShapeDestroyPtr.asFunction<void Function(ffi.Pointer<cpShape>)>();

  cpBB cpShapeCacheBB(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeCacheBB(
      shape,
    );
  }

  late final _cpShapeCacheBBPtr = _lookup<ffi.NativeFunction<cpBB Function(ffi.Pointer<cpShape>)>>('cpShapeCacheBB');
  late final _cpShapeCacheBB = _cpShapeCacheBBPtr.asFunction<cpBB Function(ffi.Pointer<cpShape>)>();

  cpBB cpShapeUpdate(
    ffi.Pointer<cpShape> shape,
    cpTransform transform,
  ) {
    return _cpShapeUpdate(
      shape,
      transform,
    );
  }

  late final _cpShapeUpdatePtr = _lookup<ffi.NativeFunction<cpBB Function(ffi.Pointer<cpShape>, cpTransform)>>('cpShapeUpdate');
  late final _cpShapeUpdate = _cpShapeUpdatePtr.asFunction<cpBB Function(ffi.Pointer<cpShape>, cpTransform)>();

  double cpShapePointQuery(
    ffi.Pointer<cpShape> shape,
    cpVect p,
    ffi.Pointer<cpPointQueryInfo> out,
  ) {
    return _cpShapePointQuery(
      shape,
      p,
      out,
    );
  }

  late final _cpShapePointQueryPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>, cpVect, ffi.Pointer<cpPointQueryInfo>)>>('cpShapePointQuery');
  late final _cpShapePointQuery = _cpShapePointQueryPtr.asFunction<double Function(ffi.Pointer<cpShape>, cpVect, ffi.Pointer<cpPointQueryInfo>)>();

  int cpShapeSegmentQuery(
    ffi.Pointer<cpShape> shape,
    cpVect a,
    cpVect b,
    double radius,
    ffi.Pointer<cpSegmentQueryInfo> info,
  ) {
    return _cpShapeSegmentQuery(
      shape,
      a,
      b,
      radius,
      info,
    );
  }

  late final _cpShapeSegmentQueryPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpShape>, cpVect, cpVect, cpFloat, ffi.Pointer<cpSegmentQueryInfo>)>>('cpShapeSegmentQuery');
  late final _cpShapeSegmentQuery = _cpShapeSegmentQueryPtr.asFunction<int Function(ffi.Pointer<cpShape>, cpVect, cpVect, double, ffi.Pointer<cpSegmentQueryInfo>)>();

  cpContactPointSet cpShapesCollide(
    ffi.Pointer<cpShape> a,
    ffi.Pointer<cpShape> b,
  ) {
    return _cpShapesCollide(
      a,
      b,
    );
  }

  late final _cpShapesCollidePtr = _lookup<ffi.NativeFunction<cpContactPointSet Function(ffi.Pointer<cpShape>, ffi.Pointer<cpShape>)>>('cpShapesCollide');
  late final _cpShapesCollide = _cpShapesCollidePtr.asFunction<cpContactPointSet Function(ffi.Pointer<cpShape>, ffi.Pointer<cpShape>)>();

  ffi.Pointer<cpSpace> cpShapeGetSpace(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetSpace(
      shape,
    );
  }

  late final _cpShapeGetSpacePtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpShape>)>>('cpShapeGetSpace');
  late final _cpShapeGetSpace = _cpShapeGetSpacePtr.asFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpShape>)>();

  ffi.Pointer<cpBody> cpShapeGetBody(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetBody(
      shape,
    );
  }

  late final _cpShapeGetBodyPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpShape>)>>('cpShapeGetBody');
  late final _cpShapeGetBody = _cpShapeGetBodyPtr.asFunction<ffi.Pointer<cpBody> Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetBody(
    ffi.Pointer<cpShape> shape,
    ffi.Pointer<cpBody> body,
  ) {
    return _cpShapeSetBody(
      shape,
      body,
    );
  }

  late final _cpShapeSetBodyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, ffi.Pointer<cpBody>)>>('cpShapeSetBody');
  late final _cpShapeSetBody = _cpShapeSetBodyPtr.asFunction<void Function(ffi.Pointer<cpShape>, ffi.Pointer<cpBody>)>();

  double cpShapeGetMass(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetMass(
      shape,
    );
  }

  late final _cpShapeGetMassPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetMass');
  late final _cpShapeGetMass = _cpShapeGetMassPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetMass(
    ffi.Pointer<cpShape> shape,
    double mass,
  ) {
    return _cpShapeSetMass(
      shape,
      mass,
    );
  }

  late final _cpShapeSetMassPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpShapeSetMass');
  late final _cpShapeSetMass = _cpShapeSetMassPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  double cpShapeGetDensity(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetDensity(
      shape,
    );
  }

  late final _cpShapeGetDensityPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetDensity');
  late final _cpShapeGetDensity = _cpShapeGetDensityPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetDensity(
    ffi.Pointer<cpShape> shape,
    double density,
  ) {
    return _cpShapeSetDensity(
      shape,
      density,
    );
  }

  late final _cpShapeSetDensityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpShapeSetDensity');
  late final _cpShapeSetDensity = _cpShapeSetDensityPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  double cpShapeGetMoment(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetMoment(
      shape,
    );
  }

  late final _cpShapeGetMomentPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetMoment');
  late final _cpShapeGetMoment = _cpShapeGetMomentPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  double cpShapeGetArea(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetArea(
      shape,
    );
  }

  late final _cpShapeGetAreaPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetArea');
  late final _cpShapeGetArea = _cpShapeGetAreaPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  cpVect cpShapeGetCenterOfGravity(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetCenterOfGravity(
      shape,
    );
  }

  late final _cpShapeGetCenterOfGravityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpShapeGetCenterOfGravity');
  late final _cpShapeGetCenterOfGravity = _cpShapeGetCenterOfGravityPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  cpBB cpShapeGetBB(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetBB(
      shape,
    );
  }

  late final _cpShapeGetBBPtr = _lookup<ffi.NativeFunction<cpBB Function(ffi.Pointer<cpShape>)>>('cpShapeGetBB');
  late final _cpShapeGetBB = _cpShapeGetBBPtr.asFunction<cpBB Function(ffi.Pointer<cpShape>)>();

  int cpShapeGetSensor(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetSensor(
      shape,
    );
  }

  late final _cpShapeGetSensorPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpShape>)>>('cpShapeGetSensor');
  late final _cpShapeGetSensor = _cpShapeGetSensorPtr.asFunction<int Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetSensor(
    ffi.Pointer<cpShape> shape,
    int sensor,
  ) {
    return _cpShapeSetSensor(
      shape,
      sensor,
    );
  }

  late final _cpShapeSetSensorPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpBool)>>('cpShapeSetSensor');
  late final _cpShapeSetSensor = _cpShapeSetSensorPtr.asFunction<void Function(ffi.Pointer<cpShape>, int)>();

  double cpShapeGetElasticity(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetElasticity(
      shape,
    );
  }

  late final _cpShapeGetElasticityPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetElasticity');
  late final _cpShapeGetElasticity = _cpShapeGetElasticityPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetElasticity(
    ffi.Pointer<cpShape> shape,
    double elasticity,
  ) {
    return _cpShapeSetElasticity(
      shape,
      elasticity,
    );
  }

  late final _cpShapeSetElasticityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpShapeSetElasticity');
  late final _cpShapeSetElasticity = _cpShapeSetElasticityPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  double cpShapeGetFriction(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetFriction(
      shape,
    );
  }

  late final _cpShapeGetFrictionPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpShapeGetFriction');
  late final _cpShapeGetFriction = _cpShapeGetFrictionPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  cpVect cpShapeGetSurfaceVelocity(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetSurfaceVelocity(
      shape,
    );
  }

  late final _cpShapeGetSurfaceVelocityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpShapeGetSurfaceVelocity');
  late final _cpShapeGetSurfaceVelocity = _cpShapeGetSurfaceVelocityPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetSurfaceVelocity(
    ffi.Pointer<cpShape> shape,
    cpVect surfaceVelocity,
  ) {
    return _cpShapeSetSurfaceVelocity(
      shape,
      surfaceVelocity,
    );
  }

  late final _cpShapeSetSurfaceVelocityPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpVect)>>('cpShapeSetSurfaceVelocity');
  late final _cpShapeSetSurfaceVelocity = _cpShapeSetSurfaceVelocityPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpVect)>();

  cpDataPointer cpShapeGetUserData(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetUserData(
      shape,
    );
  }

  late final _cpShapeGetUserDataPtr = _lookup<ffi.NativeFunction<cpDataPointer Function(ffi.Pointer<cpShape>)>>('cpShapeGetUserData');
  late final _cpShapeGetUserData = _cpShapeGetUserDataPtr.asFunction<cpDataPointer Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetUserData(
    ffi.Pointer<cpShape> shape,
    cpDataPointer userData,
  ) {
    return _cpShapeSetUserData(
      shape,
      userData,
    );
  }

  late final _cpShapeSetUserDataPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpDataPointer)>>('cpShapeSetUserData');
  late final _cpShapeSetUserData = _cpShapeSetUserDataPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpDataPointer)>();

  int cpShapeGetCollisionType(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetCollisionType(
      shape,
    );
  }

  late final _cpShapeGetCollisionTypePtr = _lookup<ffi.NativeFunction<cpCollisionType Function(ffi.Pointer<cpShape>)>>('cpShapeGetCollisionType');
  late final _cpShapeGetCollisionType = _cpShapeGetCollisionTypePtr.asFunction<int Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetCollisionType(
    ffi.Pointer<cpShape> shape,
    int collisionType,
  ) {
    return _cpShapeSetCollisionType(
      shape,
      collisionType,
    );
  }

  late final _cpShapeSetCollisionTypePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpCollisionType)>>('cpShapeSetCollisionType');
  late final _cpShapeSetCollisionType = _cpShapeSetCollisionTypePtr.asFunction<void Function(ffi.Pointer<cpShape>, int)>();

  cpShapeFilter cpShapeGetFilter(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpShapeGetFilter(
      shape,
    );
  }

  late final _cpShapeGetFilterPtr = _lookup<ffi.NativeFunction<cpShapeFilter Function(ffi.Pointer<cpShape>)>>('cpShapeGetFilter');
  late final _cpShapeGetFilter = _cpShapeGetFilterPtr.asFunction<cpShapeFilter Function(ffi.Pointer<cpShape>)>();

  void cpShapeSetFilter(
    ffi.Pointer<cpShape> shape,
    cpShapeFilter filter,
  ) {
    return _cpShapeSetFilter(
      shape,
      filter,
    );
  }

  late final _cpShapeSetFilterPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpShapeFilter)>>('cpShapeSetFilter');
  late final _cpShapeSetFilter = _cpShapeSetFilterPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpShapeFilter)>();

  ffi.Pointer<cpCircleShape> cpCircleShapeAlloc() {
    return _cpCircleShapeAlloc();
  }

  late final _cpCircleShapeAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpCircleShape> Function()>>('cpCircleShapeAlloc');
  late final _cpCircleShapeAlloc = _cpCircleShapeAllocPtr.asFunction<ffi.Pointer<cpCircleShape> Function()>();

  ffi.Pointer<cpCircleShape> cpCircleShapeInit(
    ffi.Pointer<cpCircleShape> circle,
    ffi.Pointer<cpBody> body,
    double radius,
    cpVect offset,
  ) {
    return _cpCircleShapeInit(
      circle,
      body,
      radius,
      offset,
    );
  }

  late final _cpCircleShapeInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpCircleShape> Function(ffi.Pointer<cpCircleShape>, ffi.Pointer<cpBody>, cpFloat, cpVect)>>('cpCircleShapeInit');
  late final _cpCircleShapeInit = _cpCircleShapeInitPtr.asFunction<ffi.Pointer<cpCircleShape> Function(ffi.Pointer<cpCircleShape>, ffi.Pointer<cpBody>, double, cpVect)>();

  cpVect cpCircleShapeGetOffset(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpCircleShapeGetOffset(
      shape,
    );
  }

  late final _cpCircleShapeGetOffsetPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpCircleShapeGetOffset');
  late final _cpCircleShapeGetOffset = _cpCircleShapeGetOffsetPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  double cpCircleShapeGetRadius(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpCircleShapeGetRadius(
      shape,
    );
  }

  late final _cpCircleShapeGetRadiusPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpCircleShapeGetRadius');
  late final _cpCircleShapeGetRadius = _cpCircleShapeGetRadiusPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  ffi.Pointer<cpSegmentShape> cpSegmentShapeAlloc() {
    return _cpSegmentShapeAlloc();
  }

  late final _cpSegmentShapeAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSegmentShape> Function()>>('cpSegmentShapeAlloc');
  late final _cpSegmentShapeAlloc = _cpSegmentShapeAllocPtr.asFunction<ffi.Pointer<cpSegmentShape> Function()>();

  ffi.Pointer<cpSegmentShape> cpSegmentShapeInit(
    ffi.Pointer<cpSegmentShape> seg,
    ffi.Pointer<cpBody> body,
    cpVect a,
    cpVect b,
    double radius,
  ) {
    return _cpSegmentShapeInit(
      seg,
      body,
      a,
      b,
      radius,
    );
  }

  late final _cpSegmentShapeInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpSegmentShape> Function(ffi.Pointer<cpSegmentShape>, ffi.Pointer<cpBody>, cpVect, cpVect, cpFloat)>>('cpSegmentShapeInit');
  late final _cpSegmentShapeInit = _cpSegmentShapeInitPtr.asFunction<ffi.Pointer<cpSegmentShape> Function(ffi.Pointer<cpSegmentShape>, ffi.Pointer<cpBody>, cpVect, cpVect, double)>();

  void cpSegmentShapeSetNeighbors(
    ffi.Pointer<cpShape> shape,
    cpVect prev,
    cpVect next,
  ) {
    return _cpSegmentShapeSetNeighbors(
      shape,
      prev,
      next,
    );
  }

  late final _cpSegmentShapeSetNeighborsPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpVect, cpVect)>>('cpSegmentShapeSetNeighbors');
  late final _cpSegmentShapeSetNeighbors = _cpSegmentShapeSetNeighborsPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpVect, cpVect)>();

  cpVect cpSegmentShapeGetA(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSegmentShapeGetA(
      shape,
    );
  }

  late final _cpSegmentShapeGetAPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpSegmentShapeGetA');
  late final _cpSegmentShapeGetA = _cpSegmentShapeGetAPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  cpVect cpSegmentShapeGetB(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSegmentShapeGetB(
      shape,
    );
  }

  late final _cpSegmentShapeGetBPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpSegmentShapeGetB');
  late final _cpSegmentShapeGetB = _cpSegmentShapeGetBPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  cpVect cpSegmentShapeGetNormal(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSegmentShapeGetNormal(
      shape,
    );
  }

  late final _cpSegmentShapeGetNormalPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpShape>)>>('cpSegmentShapeGetNormal');
  late final _cpSegmentShapeGetNormal = _cpSegmentShapeGetNormalPtr.asFunction<cpVect Function(ffi.Pointer<cpShape>)>();

  double cpSegmentShapeGetRadius(
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSegmentShapeGetRadius(
      shape,
    );
  }

  late final _cpSegmentShapeGetRadiusPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpShape>)>>('cpSegmentShapeGetRadius');
  late final _cpSegmentShapeGetRadius = _cpSegmentShapeGetRadiusPtr.asFunction<double Function(ffi.Pointer<cpShape>)>();

  int cpConstraintIsSimpleMotor(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpConstraintIsSimpleMotor(
      constraint,
    );
  }

  late final _cpConstraintIsSimpleMotorPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpConstraint>)>>('cpConstraintIsSimpleMotor');
  late final _cpConstraintIsSimpleMotor = _cpConstraintIsSimpleMotorPtr.asFunction<int Function(ffi.Pointer<cpConstraint>)>();

  ffi.Pointer<cpSimpleMotor> cpSimpleMotorAlloc() {
    return _cpSimpleMotorAlloc();
  }

  late final _cpSimpleMotorAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSimpleMotor> Function()>>('cpSimpleMotorAlloc');
  late final _cpSimpleMotorAlloc = _cpSimpleMotorAllocPtr.asFunction<ffi.Pointer<cpSimpleMotor> Function()>();

  ffi.Pointer<cpSimpleMotor> cpSimpleMotorInit(
    ffi.Pointer<cpSimpleMotor> joint,
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double rate,
  ) {
    return _cpSimpleMotorInit(
      joint,
      a,
      b,
      rate,
    );
  }

  late final _cpSimpleMotorInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpSimpleMotor> Function(ffi.Pointer<cpSimpleMotor>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat)>>('cpSimpleMotorInit');
  late final _cpSimpleMotorInit = _cpSimpleMotorInitPtr.asFunction<ffi.Pointer<cpSimpleMotor> Function(ffi.Pointer<cpSimpleMotor>, ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double)>();

  ffi.Pointer<cpConstraint> cpSimpleMotorNew(
    ffi.Pointer<cpBody> a,
    ffi.Pointer<cpBody> b,
    double rate,
  ) {
    return _cpSimpleMotorNew(
      a,
      b,
      rate,
    );
  }

  late final _cpSimpleMotorNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, cpFloat)>>('cpSimpleMotorNew');
  late final _cpSimpleMotorNew = _cpSimpleMotorNewPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpBody>, ffi.Pointer<cpBody>, double)>();

  double cpSimpleMotorGetRate(
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSimpleMotorGetRate(
      constraint,
    );
  }

  late final _cpSimpleMotorGetRatePtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint>)>>('cpSimpleMotorGetRate');
  late final _cpSimpleMotorGetRate = _cpSimpleMotorGetRatePtr.asFunction<double Function(ffi.Pointer<cpConstraint>)>();

  void cpSimpleMotorSetRate(
    ffi.Pointer<cpConstraint> constraint,
    double rate,
  ) {
    return _cpSimpleMotorSetRate(
      constraint,
      rate,
    );
  }

  late final _cpSimpleMotorSetRatePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint>, cpFloat)>>('cpSimpleMotorSetRate');
  late final _cpSimpleMotorSetRate = _cpSimpleMotorSetRatePtr.asFunction<void Function(ffi.Pointer<cpConstraint>, double)>();

  ffi.Pointer<cpSpace> cpSpaceAlloc() {
    return _cpSpaceAlloc();
  }

  late final _cpSpaceAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function()>>('cpSpaceAlloc');
  late final _cpSpaceAlloc = _cpSpaceAllocPtr.asFunction<ffi.Pointer<cpSpace> Function()>();

  ffi.Pointer<cpSpace> cpSpaceInit(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceInit(
      space,
    );
  }

  late final _cpSpaceInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpSpace>)>>('cpSpaceInit');
  late final _cpSpaceInit = _cpSpaceInitPtr.asFunction<ffi.Pointer<cpSpace> Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceDestroy(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceDestroy(
      space,
    );
  }

  late final _cpSpaceDestroyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>)>>('cpSpaceDestroy');
  late final _cpSpaceDestroy = _cpSpaceDestroyPtr.asFunction<void Function(ffi.Pointer<cpSpace>)>();

  int cpSpaceGetIterations(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetIterations(
      space,
    );
  }

  late final _cpSpaceGetIterationsPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetIterations');
  late final _cpSpaceGetIterations = _cpSpaceGetIterationsPtr.asFunction<int Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetIterations(
    ffi.Pointer<cpSpace> space,
    int iterations,
  ) {
    return _cpSpaceSetIterations(
      space,
      iterations,
    );
  }

  late final _cpSpaceSetIterationsPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Int)>>('cpSpaceSetIterations');
  late final _cpSpaceSetIterations = _cpSpaceSetIterationsPtr.asFunction<void Function(ffi.Pointer<cpSpace>, int)>();

  cpVect cpSpaceGetGravity(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetGravity(
      space,
    );
  }

  late final _cpSpaceGetGravityPtr = _lookup<ffi.NativeFunction<cpVect Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetGravity');
  late final _cpSpaceGetGravity = _cpSpaceGetGravityPtr.asFunction<cpVect Function(ffi.Pointer<cpSpace>)>();

  double cpSpaceGetDamping(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetDamping(
      space,
    );
  }

  late final _cpSpaceGetDampingPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetDamping');
  late final _cpSpaceGetDamping = _cpSpaceGetDampingPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetDamping(
    ffi.Pointer<cpSpace> space,
    double damping,
  ) {
    return _cpSpaceSetDamping(
      space,
      damping,
    );
  }

  late final _cpSpaceSetDampingPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceSetDamping');
  late final _cpSpaceSetDamping = _cpSpaceSetDampingPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  double cpSpaceGetIdleSpeedThreshold(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetIdleSpeedThreshold(
      space,
    );
  }

  late final _cpSpaceGetIdleSpeedThresholdPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetIdleSpeedThreshold');
  late final _cpSpaceGetIdleSpeedThreshold = _cpSpaceGetIdleSpeedThresholdPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetIdleSpeedThreshold(
    ffi.Pointer<cpSpace> space,
    double idleSpeedThreshold,
  ) {
    return _cpSpaceSetIdleSpeedThreshold(
      space,
      idleSpeedThreshold,
    );
  }

  late final _cpSpaceSetIdleSpeedThresholdPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceSetIdleSpeedThreshold');
  late final _cpSpaceSetIdleSpeedThreshold = _cpSpaceSetIdleSpeedThresholdPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  double cpSpaceGetSleepTimeThreshold(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetSleepTimeThreshold(
      space,
    );
  }

  late final _cpSpaceGetSleepTimeThresholdPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetSleepTimeThreshold');
  late final _cpSpaceGetSleepTimeThreshold = _cpSpaceGetSleepTimeThresholdPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetSleepTimeThreshold(
    ffi.Pointer<cpSpace> space,
    double sleepTimeThreshold,
  ) {
    return _cpSpaceSetSleepTimeThreshold(
      space,
      sleepTimeThreshold,
    );
  }

  late final _cpSpaceSetSleepTimeThresholdPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceSetSleepTimeThreshold');
  late final _cpSpaceSetSleepTimeThreshold = _cpSpaceSetSleepTimeThresholdPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  double cpSpaceGetCollisionSlop(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetCollisionSlop(
      space,
    );
  }

  late final _cpSpaceGetCollisionSlopPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetCollisionSlop');
  late final _cpSpaceGetCollisionSlop = _cpSpaceGetCollisionSlopPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetCollisionSlop(
    ffi.Pointer<cpSpace> space,
    double collisionSlop,
  ) {
    return _cpSpaceSetCollisionSlop(
      space,
      collisionSlop,
    );
  }

  late final _cpSpaceSetCollisionSlopPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceSetCollisionSlop');
  late final _cpSpaceSetCollisionSlop = _cpSpaceSetCollisionSlopPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  double cpSpaceGetCollisionBias(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetCollisionBias(
      space,
    );
  }

  late final _cpSpaceGetCollisionBiasPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetCollisionBias');
  late final _cpSpaceGetCollisionBias = _cpSpaceGetCollisionBiasPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetCollisionBias(
    ffi.Pointer<cpSpace> space,
    double collisionBias,
  ) {
    return _cpSpaceSetCollisionBias(
      space,
      collisionBias,
    );
  }

  late final _cpSpaceSetCollisionBiasPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpSpaceSetCollisionBias');
  late final _cpSpaceSetCollisionBias = _cpSpaceSetCollisionBiasPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  int cpSpaceGetCollisionPersistence(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetCollisionPersistence(
      space,
    );
  }

  late final _cpSpaceGetCollisionPersistencePtr = _lookup<ffi.NativeFunction<cpTimestamp Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetCollisionPersistence');
  late final _cpSpaceGetCollisionPersistence = _cpSpaceGetCollisionPersistencePtr.asFunction<int Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetCollisionPersistence(
    ffi.Pointer<cpSpace> space,
    int collisionPersistence,
  ) {
    return _cpSpaceSetCollisionPersistence(
      space,
      collisionPersistence,
    );
  }

  late final _cpSpaceSetCollisionPersistencePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpTimestamp)>>('cpSpaceSetCollisionPersistence');
  late final _cpSpaceSetCollisionPersistence = _cpSpaceSetCollisionPersistencePtr.asFunction<void Function(ffi.Pointer<cpSpace>, int)>();

  cpDataPointer cpSpaceGetUserData(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetUserData(
      space,
    );
  }

  late final _cpSpaceGetUserDataPtr = _lookup<ffi.NativeFunction<cpDataPointer Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetUserData');
  late final _cpSpaceGetUserData = _cpSpaceGetUserDataPtr.asFunction<cpDataPointer Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceSetUserData(
    ffi.Pointer<cpSpace> space,
    cpDataPointer userData,
  ) {
    return _cpSpaceSetUserData(
      space,
      userData,
    );
  }

  late final _cpSpaceSetUserDataPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpDataPointer)>>('cpSpaceSetUserData');
  late final _cpSpaceSetUserData = _cpSpaceSetUserDataPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpDataPointer)>();

  double cpSpaceGetCurrentTimeStep(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceGetCurrentTimeStep(
      space,
    );
  }

  late final _cpSpaceGetCurrentTimeStepPtr = _lookup<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpSpace>)>>('cpSpaceGetCurrentTimeStep');
  late final _cpSpaceGetCurrentTimeStep = _cpSpaceGetCurrentTimeStepPtr.asFunction<double Function(ffi.Pointer<cpSpace>)>();

  int cpSpaceIsLocked(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceIsLocked(
      space,
    );
  }

  late final _cpSpaceIsLockedPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>)>>('cpSpaceIsLocked');
  late final _cpSpaceIsLocked = _cpSpaceIsLockedPtr.asFunction<int Function(ffi.Pointer<cpSpace>)>();

  ffi.Pointer<cpCollisionHandler> cpSpaceAddDefaultCollisionHandler(
    ffi.Pointer<cpSpace> space,
    int callbackId,
  ) {
    return _cpSpaceAddDefaultCollisionHandler(
      space,
      callbackId,
    );
  }

  late final _cpSpaceAddDefaultCollisionHandlerPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, ffi.Uint64)>>('cpSpaceAddDefaultCollisionHandler');
  late final _cpSpaceAddDefaultCollisionHandler = _cpSpaceAddDefaultCollisionHandlerPtr.asFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, int)>();

  ffi.Pointer<cpCollisionHandler> cpSpaceAddCollisionHandler(
    ffi.Pointer<cpSpace> space,
    int a,
    int b,
    int callbackId,
  ) {
    return _cpSpaceAddCollisionHandler(
      space,
      a,
      b,
      callbackId,
    );
  }

  late final _cpSpaceAddCollisionHandlerPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, cpCollisionType, cpCollisionType, ffi.Uint64)>>('cpSpaceAddCollisionHandler');
  late final _cpSpaceAddCollisionHandler = _cpSpaceAddCollisionHandlerPtr.asFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, int, int, int)>();
  ffi.Pointer<cpCollisionHandler> cpSpaceAddWildcardHandler(
    ffi.Pointer<cpSpace> space,
    int type,
    int callbackId,
  ) {
    return _cpSpaceAddWildcardHandler(
      space,
      type,
      callbackId,
    );
  }

  late final _cpSpaceAddWildcardHandlerPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, cpCollisionType, ffi.Uint64)>>('cpSpaceAddWildcardHandler');
  late final _cpSpaceAddWildcardHandler = _cpSpaceAddWildcardHandlerPtr.asFunction<ffi.Pointer<cpCollisionHandler> Function(ffi.Pointer<cpSpace>, int, int)>();

  ffi.Pointer<cpConstraint> cpSpaceAddConstraint(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSpaceAddConstraint(
      space,
      constraint,
    );
  }

  late final _cpSpaceAddConstraintPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>>('cpSpaceAddConstraint');
  late final _cpSpaceAddConstraint = _cpSpaceAddConstraintPtr.asFunction<ffi.Pointer<cpConstraint> Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>();

  void cpSpaceRemoveShape(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSpaceRemoveShape(
      space,
      shape,
    );
  }

  late final _cpSpaceRemoveShapePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>>('cpSpaceRemoveShape');
  late final _cpSpaceRemoveShape = _cpSpaceRemoveShapePtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>();

  void cpSpaceRemoveBody(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpBody> body,
  ) {
    return _cpSpaceRemoveBody(
      space,
      body,
    );
  }

  late final _cpSpaceRemoveBodyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>>('cpSpaceRemoveBody');
  late final _cpSpaceRemoveBody = _cpSpaceRemoveBodyPtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>();

  void cpSpaceRemoveConstraint(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSpaceRemoveConstraint(
      space,
      constraint,
    );
  }

  late final _cpSpaceRemoveConstraintPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>>('cpSpaceRemoveConstraint');
  late final _cpSpaceRemoveConstraint = _cpSpaceRemoveConstraintPtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>();

  int cpSpaceContainsShape(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSpaceContainsShape(
      space,
      shape,
    );
  }

  late final _cpSpaceContainsShapePtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>>('cpSpaceContainsShape');
  late final _cpSpaceContainsShape = _cpSpaceContainsShapePtr.asFunction<int Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>();

  int cpSpaceContainsBody(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpBody> body,
  ) {
    return _cpSpaceContainsBody(
      space,
      body,
    );
  }

  late final _cpSpaceContainsBodyPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>>('cpSpaceContainsBody');
  late final _cpSpaceContainsBody = _cpSpaceContainsBodyPtr.asFunction<int Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>();

  int cpSpaceContainsConstraint(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpConstraint> constraint,
  ) {
    return _cpSpaceContainsConstraint(
      space,
      constraint,
    );
  }

  late final _cpSpaceContainsConstraintPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>>('cpSpaceContainsConstraint');
  late final _cpSpaceContainsConstraint = _cpSpaceContainsConstraintPtr.asFunction<int Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpConstraint>)>();

  int cpSpaceAddPostStepCallback(
    ffi.Pointer<cpSpace> space,
    cpPostStepFuncD func,
    ffi.Pointer<ffi.Void> key,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceAddPostStepCallback(
      space,
      func,
      key,
      data,
      callbackId,
    );
  }

  late final _cpSpaceAddPostStepCallbackPtr =
      _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>, cpPostStepFuncD, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceAddPostStepCallback');
  late final _cpSpaceAddPostStepCallback = _cpSpaceAddPostStepCallbackPtr.asFunction<int Function(ffi.Pointer<cpSpace>, cpPostStepFuncD, ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  void cpSpacePointQuery(
    ffi.Pointer<cpSpace> space,
    cpVect point,
    double maxDistance,
    cpShapeFilter filter,
    cpSpacePointQueryFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpacePointQuery(
      space,
      point,
      maxDistance,
      filter,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpacePointQueryPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpVect, cpFloat, cpShapeFilter, cpSpacePointQueryFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpacePointQuery');
  late final _cpSpacePointQuery = _cpSpacePointQueryPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpVect, double, cpShapeFilter, cpSpacePointQueryFuncD, ffi.Pointer<ffi.Void>, int)>();

  ffi.Pointer<cpShape> cpSpacePointQueryNearest(
    ffi.Pointer<cpSpace> space,
    cpVect point,
    double maxDistance,
    cpShapeFilter filter,
    ffi.Pointer<cpPointQueryInfo> out,
  ) {
    return _cpSpacePointQueryNearest(
      space,
      point,
      maxDistance,
      filter,
      out,
    );
  }

  late final _cpSpacePointQueryNearestPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, cpVect, cpFloat, cpShapeFilter, ffi.Pointer<cpPointQueryInfo>)>>('cpSpacePointQueryNearest');
  late final _cpSpacePointQueryNearest = _cpSpacePointQueryNearestPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, cpVect, double, cpShapeFilter, ffi.Pointer<cpPointQueryInfo>)>();

  void cpSpaceSegmentQuery(
    ffi.Pointer<cpSpace> space,
    cpVect start,
    cpVect end,
    double radius,
    cpShapeFilter filter,
    cpSpaceSegmentQueryFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceSegmentQuery(
      space,
      start,
      end,
      radius,
      filter,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceSegmentQueryPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpVect, cpVect, cpFloat, cpShapeFilter, cpSpaceSegmentQueryFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceSegmentQuery');
  late final _cpSpaceSegmentQuery =
      _cpSpaceSegmentQueryPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpVect, cpVect, double, cpShapeFilter, cpSpaceSegmentQueryFuncD, ffi.Pointer<ffi.Void>, int)>();
  ffi.Pointer<cpShape> cpSpaceSegmentQueryFirst(
    ffi.Pointer<cpSpace> space,
    cpVect start,
    cpVect end,
    double radius,
    cpShapeFilter filter,
    ffi.Pointer<cpSegmentQueryInfo> out,
  ) {
    return _cpSpaceSegmentQueryFirst(
      space,
      start,
      end,
      radius,
      filter,
      out,
    );
  }

  late final _cpSpaceSegmentQueryFirstPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, cpVect, cpVect, cpFloat, cpShapeFilter, ffi.Pointer<cpSegmentQueryInfo>)>>('cpSpaceSegmentQueryFirst');
  late final _cpSpaceSegmentQueryFirst =
      _cpSpaceSegmentQueryFirstPtr.asFunction<ffi.Pointer<cpShape> Function(ffi.Pointer<cpSpace>, cpVect, cpVect, double, cpShapeFilter, ffi.Pointer<cpSegmentQueryInfo>)>();

  void cpSpaceBBQuery(
    ffi.Pointer<cpSpace> space,
    cpBB bb,
    cpShapeFilter filter,
    cpSpaceBBQueryFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceBBQuery(
      space,
      bb,
      filter,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceBBQueryPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpBB, cpShapeFilter, cpSpaceBBQueryFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceBBQuery');
  late final _cpSpaceBBQuery = _cpSpaceBBQueryPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpBB, cpShapeFilter, cpSpaceBBQueryFuncD, ffi.Pointer<ffi.Void>, int)>();
  int cpSpaceShapeQuery(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpShape> shape,
    cpSpaceShapeQueryFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceShapeQuery(
      space,
      shape,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceShapeQueryPtr =
      _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>, cpSpaceShapeQueryFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceShapeQuery');
  late final _cpSpaceShapeQuery = _cpSpaceShapeQueryPtr.asFunction<int Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>, cpSpaceShapeQueryFuncD, ffi.Pointer<ffi.Void>, int)>();
  void cpSpaceEachBody(
    ffi.Pointer<cpSpace> space,
    cpSpaceBodyIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceEachBody(
      space,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceEachBodyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpSpaceBodyIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceEachBody');
  late final _cpSpaceEachBody = _cpSpaceEachBodyPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpSpaceBodyIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();

  void cpSpaceEachShape(
    ffi.Pointer<cpSpace> space,
    cpSpaceShapeIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceEachShape(
      space,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceEachShapePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpSpaceShapeIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceEachShape');
  late final _cpSpaceEachShape = _cpSpaceEachShapePtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpSpaceShapeIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();

  void cpSpaceEachConstraint(
    ffi.Pointer<cpSpace> space,
    cpSpaceConstraintIteratorFuncD func,
    ffi.Pointer<ffi.Void> data,
    int callbackId,
  ) {
    return _cpSpaceEachConstraint(
      space,
      func,
      data,
      callbackId,
    );
  }

  late final _cpSpaceEachConstraintPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpSpaceConstraintIteratorFuncD, ffi.Pointer<ffi.Void>, ffi.Uint64)>>('cpSpaceEachConstraint');
  late final _cpSpaceEachConstraint = _cpSpaceEachConstraintPtr.asFunction<void Function(ffi.Pointer<cpSpace>, cpSpaceConstraintIteratorFuncD, ffi.Pointer<ffi.Void>, int)>();
  void cpSpaceReindexStatic(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpSpaceReindexStatic(
      space,
    );
  }

  late final _cpSpaceReindexStaticPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>)>>('cpSpaceReindexStatic');
  late final _cpSpaceReindexStatic = _cpSpaceReindexStaticPtr.asFunction<void Function(ffi.Pointer<cpSpace>)>();

  void cpSpaceReindexShape(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpShape> shape,
  ) {
    return _cpSpaceReindexShape(
      space,
      shape,
    );
  }

  late final _cpSpaceReindexShapePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>>('cpSpaceReindexShape');
  late final _cpSpaceReindexShape = _cpSpaceReindexShapePtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpShape>)>();

  void cpSpaceReindexShapesForBody(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpBody> body,
  ) {
    return _cpSpaceReindexShapesForBody(
      space,
      body,
    );
  }

  late final _cpSpaceReindexShapesForBodyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>>('cpSpaceReindexShapesForBody');
  late final _cpSpaceReindexShapesForBody = _cpSpaceReindexShapesForBodyPtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpBody>)>();

  void cpSpaceUseSpatialHash(
    ffi.Pointer<cpSpace> space,
    double dim,
    int count,
  ) {
    return _cpSpaceUseSpatialHash(
      space,
      dim,
      count,
    );
  }

  late final _cpSpaceUseSpatialHashPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat, ffi.Int)>>('cpSpaceUseSpatialHash');
  late final _cpSpaceUseSpatialHash = _cpSpaceUseSpatialHashPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double, int)>();

  void cpSpaceDebugDraw(
    ffi.Pointer<cpSpace> space,
    ffi.Pointer<cpSpaceDebugDrawOptions> options,
  ) {
    return _cpSpaceDebugDraw(
      space,
      options,
    );
  }

  late final _cpSpaceDebugDrawPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpSpaceDebugDrawOptions>)>>('cpSpaceDebugDraw');
  late final _cpSpaceDebugDraw = _cpSpaceDebugDrawPtr.asFunction<void Function(ffi.Pointer<cpSpace>, ffi.Pointer<cpSpaceDebugDrawOptions>)>();

  ffi.Pointer<cpSpaceHash> cpSpaceHashAlloc() {
    return _cpSpaceHashAlloc();
  }

  late final _cpSpaceHashAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpaceHash> Function()>>('cpSpaceHashAlloc');
  late final _cpSpaceHashAlloc = _cpSpaceHashAllocPtr.asFunction<ffi.Pointer<cpSpaceHash> Function()>();

  ffi.Pointer<cpSpatialIndex> cpSpaceHashInit(
    ffi.Pointer<cpSpaceHash> hash,
    double celldim,
    int numcells,
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpSpaceHashInit(
      hash,
      celldim,
      numcells,
      bbfunc,
      staticIndex,
    );
  }

  late final _cpSpaceHashInitPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpSpaceHash>, cpFloat, ffi.Int, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpSpaceHashInit');
  late final _cpSpaceHashInit = _cpSpaceHashInitPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpSpaceHash>, double, int, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  ffi.Pointer<cpSpatialIndex> cpSpaceHashNew(
    double celldim,
    int cells,
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpSpaceHashNew(
      celldim,
      cells,
      bbfunc,
      staticIndex,
    );
  }

  late final _cpSpaceHashNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(cpFloat, ffi.Int, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpSpaceHashNew');
  late final _cpSpaceHashNew = _cpSpaceHashNewPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(double, int, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  void cpSpaceHashResize(
    ffi.Pointer<cpSpaceHash> hash,
    double celldim,
    int numcells,
  ) {
    return _cpSpaceHashResize(
      hash,
      celldim,
      numcells,
    );
  }

  late final _cpSpaceHashResizePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpaceHash>, cpFloat, ffi.Int)>>('cpSpaceHashResize');
  late final _cpSpaceHashResize = _cpSpaceHashResizePtr.asFunction<void Function(ffi.Pointer<cpSpaceHash>, double, int)>();

  ffi.Pointer<cpBBTree> cpBBTreeAlloc() {
    return _cpBBTreeAlloc();
  }

  late final _cpBBTreeAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpBBTree> Function()>>('cpBBTreeAlloc');
  late final _cpBBTreeAlloc = _cpBBTreeAllocPtr.asFunction<ffi.Pointer<cpBBTree> Function()>();

  ffi.Pointer<cpSpatialIndex> cpBBTreeInit(
    ffi.Pointer<cpBBTree> tree,
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpBBTreeInit(
      tree,
      bbfunc,
      staticIndex,
    );
  }

  late final _cpBBTreeInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpBBTree>, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpBBTreeInit');
  late final _cpBBTreeInit = _cpBBTreeInitPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpBBTree>, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  ffi.Pointer<cpSpatialIndex> cpBBTreeNew(
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpBBTreeNew(
      bbfunc,
      staticIndex,
    );
  }

  late final _cpBBTreeNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpBBTreeNew');
  late final _cpBBTreeNew = _cpBBTreeNewPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  void cpBBTreeOptimize(
    ffi.Pointer<cpSpatialIndex> index,
  ) {
    return _cpBBTreeOptimize(
      index,
    );
  }

  late final _cpBBTreeOptimizePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex>)>>('cpBBTreeOptimize');
  late final _cpBBTreeOptimize = _cpBBTreeOptimizePtr.asFunction<void Function(ffi.Pointer<cpSpatialIndex>)>();

  void cpBBTreeSetVelocityFunc(
    ffi.Pointer<cpSpatialIndex> index,
    cpBBTreeVelocityFunc func,
  ) {
    return _cpBBTreeSetVelocityFunc(
      index,
      func,
    );
  }

  late final _cpBBTreeSetVelocityFuncPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex>, cpBBTreeVelocityFunc)>>('cpBBTreeSetVelocityFunc');
  late final _cpBBTreeSetVelocityFunc = _cpBBTreeSetVelocityFuncPtr.asFunction<void Function(ffi.Pointer<cpSpatialIndex>, cpBBTreeVelocityFunc)>();

  ffi.Pointer<cpSweep1D> cpSweep1DAlloc() {
    return _cpSweep1DAlloc();
  }

  late final _cpSweep1DAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSweep1D> Function()>>('cpSweep1DAlloc');
  late final _cpSweep1DAlloc = _cpSweep1DAllocPtr.asFunction<ffi.Pointer<cpSweep1D> Function()>();

  ffi.Pointer<cpSpatialIndex> cpSweep1DInit(
    ffi.Pointer<cpSweep1D> sweep,
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpSweep1DInit(
      sweep,
      bbfunc,
      staticIndex,
    );
  }

  late final _cpSweep1DInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpSweep1D>, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpSweep1DInit');
  late final _cpSweep1DInit = _cpSweep1DInitPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(ffi.Pointer<cpSweep1D>, cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  ffi.Pointer<cpSpatialIndex> cpSweep1DNew(
    cpSpatialIndexBBFunc bbfunc,
    ffi.Pointer<cpSpatialIndex> staticIndex,
  ) {
    return _cpSweep1DNew(
      bbfunc,
      staticIndex,
    );
  }

  late final _cpSweep1DNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpatialIndex> Function(cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>>('cpSweep1DNew');
  late final _cpSweep1DNew = _cpSweep1DNewPtr.asFunction<ffi.Pointer<cpSpatialIndex> Function(cpSpatialIndexBBFunc, ffi.Pointer<cpSpatialIndex>)>();

  void cpSpatialIndexFree(
    ffi.Pointer<cpSpatialIndex> index,
  ) {
    return _cpSpatialIndexFree(
      index,
    );
  }

  late final _cpSpatialIndexFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex>)>>('cpSpatialIndexFree');
  late final _cpSpatialIndexFree = _cpSpatialIndexFreePtr.asFunction<void Function(ffi.Pointer<cpSpatialIndex>)>();

  void cpSpatialIndexCollideStatic(
    ffi.Pointer<cpSpatialIndex> dynamicIndex,
    ffi.Pointer<cpSpatialIndex> staticIndex,
    cpSpatialIndexQueryFunc func,
    ffi.Pointer<ffi.Void> data,
  ) {
    return _cpSpatialIndexCollideStatic(
      dynamicIndex,
      staticIndex,
      func,
      data,
    );
  }

  late final _cpSpatialIndexCollideStaticPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex>, ffi.Pointer<cpSpatialIndex>, cpSpatialIndexQueryFunc, ffi.Pointer<ffi.Void>)>>('cpSpatialIndexCollideStatic');
  late final _cpSpatialIndexCollideStatic =
      _cpSpatialIndexCollideStaticPtr.asFunction<void Function(ffi.Pointer<cpSpatialIndex>, ffi.Pointer<cpSpatialIndex>, cpSpatialIndexQueryFunc, ffi.Pointer<ffi.Void>)>();

  void cpCircleShapeSetRadius(
    ffi.Pointer<cpShape> shape,
    double radius,
  ) {
    return _cpCircleShapeSetRadius(
      shape,
      radius,
    );
  }

  late final _cpCircleShapeSetRadiusPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpCircleShapeSetRadius');
  late final _cpCircleShapeSetRadius = _cpCircleShapeSetRadiusPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  void cpCircleShapeSetOffset(
    ffi.Pointer<cpShape> shape,
    cpVect offset,
  ) {
    return _cpCircleShapeSetOffset(
      shape,
      offset,
    );
  }

  late final _cpCircleShapeSetOffsetPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpVect)>>('cpCircleShapeSetOffset');
  late final _cpCircleShapeSetOffset = _cpCircleShapeSetOffsetPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpVect)>();

  void cpSegmentShapeSetEndpoints(
    ffi.Pointer<cpShape> shape,
    cpVect a,
    cpVect b,
  ) {
    return _cpSegmentShapeSetEndpoints(
      shape,
      a,
      b,
    );
  }

  late final _cpSegmentShapeSetEndpointsPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpVect, cpVect)>>('cpSegmentShapeSetEndpoints');
  late final _cpSegmentShapeSetEndpoints = _cpSegmentShapeSetEndpointsPtr.asFunction<void Function(ffi.Pointer<cpShape>, cpVect, cpVect)>();

  void cpSegmentShapeSetRadius(
    ffi.Pointer<cpShape> shape,
    double radius,
  ) {
    return _cpSegmentShapeSetRadius(
      shape,
      radius,
    );
  }

  late final _cpSegmentShapeSetRadiusPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpSegmentShapeSetRadius');
  late final _cpSegmentShapeSetRadius = _cpSegmentShapeSetRadiusPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  void cpPolyShapeSetVerts(
    ffi.Pointer<cpShape> shape,
    int count,
    ffi.Pointer<cpVect> verts,
    cpTransform transform,
  ) {
    return _cpPolyShapeSetVerts(
      shape,
      count,
      verts,
      transform,
    );
  }

  late final _cpPolyShapeSetVertsPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, ffi.Int, ffi.Pointer<cpVect>, cpTransform)>>('cpPolyShapeSetVerts');
  late final _cpPolyShapeSetVerts = _cpPolyShapeSetVertsPtr.asFunction<void Function(ffi.Pointer<cpShape>, int, ffi.Pointer<cpVect>, cpTransform)>();

  void cpPolyShapeSetVertsRaw(
    ffi.Pointer<cpShape> shape,
    int count,
    ffi.Pointer<cpVect> verts,
  ) {
    return _cpPolyShapeSetVertsRaw(
      shape,
      count,
      verts,
    );
  }

  late final _cpPolyShapeSetVertsRawPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, ffi.Int, ffi.Pointer<cpVect>)>>('cpPolyShapeSetVertsRaw');
  late final _cpPolyShapeSetVertsRaw = _cpPolyShapeSetVertsRawPtr.asFunction<void Function(ffi.Pointer<cpShape>, int, ffi.Pointer<cpVect>)>();

  void cpPolyShapeSetRadius(
    ffi.Pointer<cpShape> shape,
    double radius,
  ) {
    return _cpPolyShapeSetRadius(
      shape,
      radius,
    );
  }

  late final _cpPolyShapeSetRadiusPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape>, cpFloat)>>('cpPolyShapeSetRadius');
  late final _cpPolyShapeSetRadius = _cpPolyShapeSetRadiusPtr.asFunction<void Function(ffi.Pointer<cpShape>, double)>();

  ffi.Pointer<cpSpace> cpHastySpaceNew() {
    return _cpHastySpaceNew();
  }

  late final _cpHastySpaceNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpSpace> Function()>>('cpHastySpaceNew');
  late final _cpHastySpaceNew = _cpHastySpaceNewPtr.asFunction<ffi.Pointer<cpSpace> Function()>();

  void cpHastySpaceFree(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpHastySpaceFree(
      space,
    );
  }

  late final _cpHastySpaceFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>)>>('cpHastySpaceFree');
  late final _cpHastySpaceFree = _cpHastySpaceFreePtr.asFunction<void Function(ffi.Pointer<cpSpace>)>();

  void cpHastySpaceSetThreads(
    ffi.Pointer<cpSpace> space,
    int threads,
  ) {
    return _cpHastySpaceSetThreads(
      space,
      threads,
    );
  }

  late final _cpHastySpaceSetThreadsPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, ffi.UnsignedLong)>>('cpHastySpaceSetThreads');
  late final _cpHastySpaceSetThreads = _cpHastySpaceSetThreadsPtr.asFunction<void Function(ffi.Pointer<cpSpace>, int)>();

  int cpHastySpaceGetThreads(
    ffi.Pointer<cpSpace> space,
  ) {
    return _cpHastySpaceGetThreads(
      space,
    );
  }

  late final _cpHastySpaceGetThreadsPtr = _lookup<ffi.NativeFunction<ffi.UnsignedLong Function(ffi.Pointer<cpSpace>)>>('cpHastySpaceGetThreads');
  late final _cpHastySpaceGetThreads = _cpHastySpaceGetThreadsPtr.asFunction<int Function(ffi.Pointer<cpSpace>)>();

  void cpHastySpaceStep(
    ffi.Pointer<cpSpace> space,
    double dt,
  ) {
    return _cpHastySpaceStep(
      space,
      dt,
    );
  }

  late final _cpHastySpaceStepPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace>, cpFloat)>>('cpHastySpaceStep');
  late final _cpHastySpaceStep = _cpHastySpaceStepPtr.asFunction<void Function(ffi.Pointer<cpSpace>, double)>();

  void cpPolylineFree(
    ffi.Pointer<cpPolyline> line,
  ) {
    return _cpPolylineFree(
      line,
    );
  }

  late final _cpPolylineFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpPolyline>)>>('cpPolylineFree');
  late final _cpPolylineFree = _cpPolylineFreePtr.asFunction<void Function(ffi.Pointer<cpPolyline>)>();

  int cpPolylineIsClosed(
    ffi.Pointer<cpPolyline> line,
  ) {
    return _cpPolylineIsClosed(
      line,
    );
  }

  late final _cpPolylineIsClosedPtr = _lookup<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpPolyline>)>>('cpPolylineIsClosed');
  late final _cpPolylineIsClosed = _cpPolylineIsClosedPtr.asFunction<int Function(ffi.Pointer<cpPolyline>)>();

  ffi.Pointer<cpPolyline> cpPolylineSimplifyCurves(
    ffi.Pointer<cpPolyline> line,
    double tol,
  ) {
    return _cpPolylineSimplifyCurves(
      line,
      tol,
    );
  }

  late final _cpPolylineSimplifyCurvesPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, cpFloat)>>('cpPolylineSimplifyCurves');
  late final _cpPolylineSimplifyCurves = _cpPolylineSimplifyCurvesPtr.asFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, double)>();

  ffi.Pointer<cpPolyline> cpPolylineSimplifyVertexes(
    ffi.Pointer<cpPolyline> line,
    double tol,
  ) {
    return _cpPolylineSimplifyVertexes(
      line,
      tol,
    );
  }

  late final _cpPolylineSimplifyVertexesPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, cpFloat)>>('cpPolylineSimplifyVertexes');
  late final _cpPolylineSimplifyVertexes = _cpPolylineSimplifyVertexesPtr.asFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, double)>();

  ffi.Pointer<cpPolyline> cpPolylineToConvexHull(
    ffi.Pointer<cpPolyline> line,
    double tol,
  ) {
    return _cpPolylineToConvexHull(
      line,
      tol,
    );
  }

  late final _cpPolylineToConvexHullPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, cpFloat)>>('cpPolylineToConvexHull');
  late final _cpPolylineToConvexHull = _cpPolylineToConvexHullPtr.asFunction<ffi.Pointer<cpPolyline> Function(ffi.Pointer<cpPolyline>, double)>();

  ffi.Pointer<cpPolylineSet> cpPolylineSetAlloc() {
    return _cpPolylineSetAlloc();
  }

  late final _cpPolylineSetAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolylineSet> Function()>>('cpPolylineSetAlloc');
  late final _cpPolylineSetAlloc = _cpPolylineSetAllocPtr.asFunction<ffi.Pointer<cpPolylineSet> Function()>();

  ffi.Pointer<cpPolylineSet> cpPolylineSetInit(
    ffi.Pointer<cpPolylineSet> set1,
  ) {
    return _cpPolylineSetInit(
      set1,
    );
  }

  late final _cpPolylineSetInitPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolylineSet> Function(ffi.Pointer<cpPolylineSet>)>>('cpPolylineSetInit');
  late final _cpPolylineSetInit = _cpPolylineSetInitPtr.asFunction<ffi.Pointer<cpPolylineSet> Function(ffi.Pointer<cpPolylineSet>)>();

  ffi.Pointer<cpPolylineSet> cpPolylineSetNew() {
    return _cpPolylineSetNew();
  }

  late final _cpPolylineSetNewPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolylineSet> Function()>>('cpPolylineSetNew');
  late final _cpPolylineSetNew = _cpPolylineSetNewPtr.asFunction<ffi.Pointer<cpPolylineSet> Function()>();

  void cpPolylineSetDestroy(
    ffi.Pointer<cpPolylineSet> set1,
    int freePolylines,
  ) {
    return _cpPolylineSetDestroy(
      set1,
      freePolylines,
    );
  }

  late final _cpPolylineSetDestroyPtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpPolylineSet>, cpBool)>>('cpPolylineSetDestroy');
  late final _cpPolylineSetDestroy = _cpPolylineSetDestroyPtr.asFunction<void Function(ffi.Pointer<cpPolylineSet>, int)>();

  void cpPolylineSetFree(
    ffi.Pointer<cpPolylineSet> set1,
    int freePolylines,
  ) {
    return _cpPolylineSetFree(
      set1,
      freePolylines,
    );
  }

  late final _cpPolylineSetFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpPolylineSet>, cpBool)>>('cpPolylineSetFree');
  late final _cpPolylineSetFree = _cpPolylineSetFreePtr.asFunction<void Function(ffi.Pointer<cpPolylineSet>, int)>();

  void cpPolylineSetCollectSegment(
    cpVect v0,
    cpVect v1,
    ffi.Pointer<cpPolylineSet> lines,
  ) {
    return _cpPolylineSetCollectSegment(
      v0,
      v1,
      lines,
    );
  }

  late final _cpPolylineSetCollectSegmentPtr = _lookup<ffi.NativeFunction<ffi.Void Function(cpVect, cpVect, ffi.Pointer<cpPolylineSet>)>>('cpPolylineSetCollectSegment');
  late final _cpPolylineSetCollectSegment = _cpPolylineSetCollectSegmentPtr.asFunction<void Function(cpVect, cpVect, ffi.Pointer<cpPolylineSet>)>();

  ffi.Pointer<cpPolylineSet> cpPolylineConvexDecomposition(
    ffi.Pointer<cpPolyline> line,
    double tol,
  ) {
    return _cpPolylineConvexDecomposition(
      line,
      tol,
    );
  }

  late final _cpPolylineConvexDecompositionPtr = _lookup<ffi.NativeFunction<ffi.Pointer<cpPolylineSet> Function(ffi.Pointer<cpPolyline>, cpFloat)>>('cpPolylineConvexDecomposition');
  late final _cpPolylineConvexDecomposition = _cpPolylineConvexDecompositionPtr.asFunction<ffi.Pointer<cpPolylineSet> Function(ffi.Pointer<cpPolyline>, double)>();
}

final class cpVect extends ffi.Struct {
  @cpFloat()
  external double x;

  @cpFloat()
  external double y;
}

typedef cpFloat = ffi.Double;

final class cpArray extends ffi.Struct {
  @ffi.Int()
  external int num;

  @ffi.Int()
  external int max;

  external ffi.Pointer<ffi.Pointer<ffi.Void>> arr;
}

final class cpTransform extends ffi.Struct {
  @cpFloat()
  external double a;

  @cpFloat()
  external double b;

  @cpFloat()
  external double c;

  @cpFloat()
  external double d;

  @cpFloat()
  external double tx;

  @cpFloat()
  external double ty;
}

final class cpBB extends ffi.Struct {
  @cpFloat()
  external double l;

  @cpFloat()
  external double b;

  @cpFloat()
  external double r;

  @cpFloat()
  external double t;
}

final class cpSpatialIndex extends ffi.Struct {
  external ffi.Pointer<cpSpatialIndexClass> klass;

  external cpSpatialIndexBBFunc bbfunc;

  external ffi.Pointer<cpSpatialIndex> staticIndex;

  external ffi.Pointer<cpSpatialIndex> dynamicIndex;
}

final class cpSpatialIndexClass extends ffi.Struct {
  external cpSpatialIndexDestroyImpl destroy;

  external cpSpatialIndexCountImpl count;

  external cpSpatialIndexEachImpl each;

  external cpSpatialIndexContainsImpl contains;

  external cpSpatialIndexInsertImpl insert;

  external cpSpatialIndexRemoveImpl remove;

  external cpSpatialIndexReindexImpl reindex;

  external cpSpatialIndexReindexObjectImpl reindexObject;

  external cpSpatialIndexReindexQueryImpl reindexQuery;

  external cpSpatialIndexQueryImpl query;

  external cpSpatialIndexSegmentQueryImpl segmentQuery;
}

typedef cpSpatialIndexDestroyImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index)>>;
typedef cpSpatialIndexCountImpl = ffi.Pointer<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<cpSpatialIndex> index)>>;
typedef cpSpatialIndexEachImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, cpSpatialIndexIteratorFunc func, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexIteratorFunc = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void> obj, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexContainsImpl = ffi.Pointer<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpHashValue hashid)>>;
typedef cpBool = ffi.UnsignedChar;
typedef cpHashValue = ffi.UintPtr;
typedef cpSpatialIndexInsertImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpHashValue hashid)>>;
typedef cpSpatialIndexRemoveImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpHashValue hashid)>>;
typedef cpSpatialIndexReindexImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index)>>;
typedef cpSpatialIndexReindexObjectImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpHashValue hashid)>>;
typedef cpSpatialIndexReindexQueryImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, cpSpatialIndexQueryFunc func, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexQueryFunc = ffi.Pointer<ffi.NativeFunction<cpCollisionID Function(ffi.Pointer<ffi.Void> obj1, ffi.Pointer<ffi.Void> obj2, cpCollisionID id, ffi.Pointer<ffi.Void> data)>>;
typedef cpCollisionID = ffi.Uint32;
typedef cpSpatialIndexQueryImpl
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpBB bb, cpSpatialIndexQueryFunc func, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexSegmentQueryImpl = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Void Function(ffi.Pointer<cpSpatialIndex> index, ffi.Pointer<ffi.Void> obj, cpVect a, cpVect b, cpFloat t_exit, cpSpatialIndexSegmentQueryFunc func, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexSegmentQueryFunc = ffi.Pointer<ffi.NativeFunction<cpFloat Function(ffi.Pointer<ffi.Void> obj1, ffi.Pointer<ffi.Void> obj2, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpatialIndexBBFunc = ffi.Pointer<ffi.NativeFunction<cpBB Function(ffi.Pointer<ffi.Void> obj)>>;

final class cpContactBufferHeader extends ffi.Opaque {}

final class cpHashSet extends ffi.Opaque {}

final class cpCollisionHandler extends ffi.Struct {
  @cpCollisionType()
  external int typeA;

  @cpCollisionType()
  external int typeB;

  external cpCollisionBeginFuncD beginFunc;

  external cpCollisionPreSolveFuncD preSolveFunc;

  external cpCollisionPostSolveFuncD postSolveFunc;

  external cpCollisionSeparateFuncD separateFunc;

  external cpDataPointer userData;

  @ffi.Uint64()
  external int callbackId;
}

typedef cpCollisionType = ffi.UintPtr;
typedef cpCollisionBeginFuncD = ffi.Pointer<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter> arb, ffi.Pointer<cpSpace> space, cpDataPointer userData, ffi.Uint64 callbackId)>>;

final class cpArbiter extends ffi.Struct {
  @cpFloat()
  external double e;

  @cpFloat()
  external double u;

  external cpVect surface_vr;

  external cpDataPointer data;

  external ffi.Pointer<cpShape> a;

  external ffi.Pointer<cpShape> b;

  external ffi.Pointer<cpBody> body_a;

  external ffi.Pointer<cpBody> body_b;

  external cpArbiterThread thread_a;

  external cpArbiterThread thread_b;

  @ffi.Int()
  external int count;

  external ffi.Pointer<cpContact> contacts;

  external cpVect n;

  external ffi.Pointer<cpCollisionHandler> handler;

  external ffi.Pointer<cpCollisionHandler> handlerA;

  external ffi.Pointer<cpCollisionHandler> handlerB;

  @cpBool()
  external int swapped;

  @cpTimestamp()
  external int stamp;

  @ffi.Int32()
  external int state;
}

typedef cpDataPointer = ffi.Pointer<ffi.Void>;

final class cpShape extends ffi.Struct {
  external ffi.Pointer<cpShapeClass> klass;

  external ffi.Pointer<cpSpace> space;

  external ffi.Pointer<cpBody> body;

  external cpShapeMassInfo massInfo;

  external cpBB bb;

  @cpBool()
  external int sensor;

  @cpFloat()
  external double e;

  @cpFloat()
  external double u;

  external cpVect surfaceV;

  external cpDataPointer userData;

  @cpCollisionType()
  external int type;

  external cpShapeFilter filter;

  external ffi.Pointer<cpShape> next;

  external ffi.Pointer<cpShape> prev;

  @cpHashValue()
  external int hashid;
}

final class cpShapeClass extends ffi.Struct {
  @ffi.Int32()
  external int type;

  external cpShapeCacheDataImpl cacheData;

  external cpShapeDestroyImpl destroy;

  external cpShapePointQueryImpl pointQuery;

  external cpShapeSegmentQueryImpl segmentQuery;
}

abstract class cpShapeType {
  static const int CP_CIRCLE_SHAPE = 0;
  static const int CP_SEGMENT_SHAPE = 1;
  static const int CP_POLY_SHAPE = 2;
  static const int CP_NUM_SHAPES = 3;
}

typedef cpShapeCacheDataImpl = ffi.Pointer<ffi.NativeFunction<cpBB Function(ffi.Pointer<cpShape> shape, cpTransform transform)>>;
typedef cpShapeDestroyImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape)>>;
typedef cpShapePointQueryImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, cpVect p, ffi.Pointer<cpPointQueryInfo> info)>>;

/// Point query info struct.
final class cpPointQueryInfo extends ffi.Struct {
  /// The nearest shape, NULL if no shape was within range.
  external ffi.Pointer<cpShape> shape;

  /// The closest point on the shape's surface. (in world space coordinates)
  external cpVect point;

  /// The distance to the point. The distance is negative if the point is inside the shape.
  @cpFloat()
  external double distance;

  /// The gradient of the signed distance function.
  /// The value should be similar to info.p/info.d, but accurate even for very small values of info.d.
  external cpVect gradient;
}

typedef cpShapeSegmentQueryImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, cpVect a, cpVect b, cpFloat radius, ffi.Pointer<cpSegmentQueryInfo> info)>>;

/// Segment query info struct.
final class cpSegmentQueryInfo extends ffi.Struct {
  /// The shape that was hit, or NULL if no collision occured.
  external ffi.Pointer<cpShape> shape;

  /// The point of impact.
  external cpVect point;

  /// The normal of the surface hit.
  external cpVect normal;

  /// The normalized distance along the query segment in the range [0, 1].
  @cpFloat()
  external double alpha;
}

final class cpSpace extends ffi.Struct {
  @ffi.Int()
  external int iterations;

  external cpVect gravity;

  @cpFloat()
  external double damping;

  @cpFloat()
  external double idleSpeedThreshold;

  @cpFloat()
  external double sleepTimeThreshold;

  @cpFloat()
  external double collisionSlop;

  @cpFloat()
  external double collisionBias;

  @cpTimestamp()
  external int collisionPersistence;

  external cpDataPointer userData;

  @cpTimestamp()
  external int stamp;

  @cpFloat()
  external double curr_dt;

  external ffi.Pointer<cpArray> dynamicBodies;

  external ffi.Pointer<cpArray> staticBodies;

  external ffi.Pointer<cpArray> rousedBodies;

  external ffi.Pointer<cpArray> sleepingComponents;

  @cpHashValue()
  external int shapeIDCounter;

  external ffi.Pointer<cpSpatialIndex> staticShapes;

  external ffi.Pointer<cpSpatialIndex> dynamicShapes;

  external ffi.Pointer<cpArray> constraints;

  external ffi.Pointer<cpArray> arbiters;

  external ffi.Pointer<cpContactBufferHeader> contactBuffersHead;

  external ffi.Pointer<cpHashSet> cachedArbiters;

  external ffi.Pointer<cpArray> pooledArbiters;

  external ffi.Pointer<cpArray> allocatedBuffers;

  @ffi.UnsignedInt()
  external int locked;

  @cpBool()
  external int usesWildcards;

  external ffi.Pointer<cpHashSet> collisionHandlers;

  external cpCollisionHandler defaultHandler;

  @cpBool()
  external int skipPostStep;

  external ffi.Pointer<cpArray> postStepCallbacks;

  external ffi.Pointer<cpBody> staticBody;

  external cpBody _staticBody;
}

typedef cpTimestamp = ffi.UnsignedInt;

final class cpBody extends ffi.Struct {
  external cpBodyVelocityFuncD velocity_func;

  external cpBodyPositionFuncD position_func;

  @cpFloat()
  external double m;

  @cpFloat()
  external double m_inv;

  @cpFloat()
  external double i;

  @cpFloat()
  external double i_inv;

  external cpVect cog;

  external cpVect p;

  external cpVect v;

  external cpVect f;

  @cpFloat()
  external double a;

  @cpFloat()
  external double w;

  @cpFloat()
  external double t;

  external cpTransform transform;

  external cpDataPointer userData;

  external cpVect v_bias;

  @cpFloat()
  external double w_bias;

  external ffi.Pointer<cpSpace> space;

  external ffi.Pointer<cpShape> shapeList;

  external ffi.Pointer<cpArbiter> arbiterList;

  external ffi.Pointer<cpConstraint> constraintList;

  external UnnamedStruct1 sleeping;
}

/// Rigid body velocity update function type.
typedef cpBodyVelocityFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, cpVect gravity, cpFloat damping, cpFloat dt, ffi.Uint64 callbackId)>>;

/// Rigid body position update function type.
typedef cpBodyPositionFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, cpFloat dt, ffi.Uint64 callbackId)>>;

final class cpConstraint extends ffi.Struct {
  external ffi.Pointer<cpConstraintClass> klass;

  external ffi.Pointer<cpSpace> space;

  external ffi.Pointer<cpBody> a;

  external ffi.Pointer<cpBody> b;

  external ffi.Pointer<cpConstraint> next_a;

  external ffi.Pointer<cpConstraint> next_b;

  @cpFloat()
  external double maxForce;

  @cpFloat()
  external double errorBias;

  @cpFloat()
  external double maxBias;

  @cpBool()
  external int collideBodies;

  external cpConstraintPreSolveFuncD preSolve;

  external cpConstraintPostSolveFuncD postSolve;

  external cpDataPointer userData;
}

final class cpConstraintClass extends ffi.Struct {
  external cpConstraintPreStepImpl preStep;

  external cpConstraintApplyCachedImpulseImpl applyCachedImpulse;

  external cpConstraintApplyImpulseImpl applyImpulse;

  external cpConstraintGetImpulseImpl getImpulse;
}

typedef cpConstraintPreStepImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, cpFloat dt)>>;
typedef cpConstraintApplyCachedImpulseImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, cpFloat dt_coef)>>;
typedef cpConstraintApplyImpulseImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, cpFloat dt)>>;
typedef cpConstraintGetImpulseImpl = ffi.Pointer<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint> constraint)>>;

/// Callback function type that gets called before solving a joint.
typedef cpConstraintPreSolveFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, ffi.Pointer<cpSpace> space, ffi.Uint64 callbackId)>>;

/// Callback function type that gets called after solving a joint.
typedef cpConstraintPostSolveFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, ffi.Pointer<cpSpace> space, ffi.Uint64 callbackId)>>;

final class UnnamedStruct1 extends ffi.Struct {
  external ffi.Pointer<cpBody> root;

  external ffi.Pointer<cpBody> next;

  @cpFloat()
  external double idleTime;
}

final class cpShapeMassInfo extends ffi.Struct {
  @cpFloat()
  external double m;

  @cpFloat()
  external double i;

  external cpVect cog;

  @cpFloat()
  external double area;
}

/// Fast collision filtering type that is used to determine if two objects collide before calling collision or query callbacks.
final class cpShapeFilter extends ffi.Struct {
  /// Two objects with the same non-zero group value do not collide.
  /// This is generally used to group objects in a composite object together to disable self collisions.
  @cpGroup()
  external int group;

  /// A bitmask of user definable categories that this object belongs to.
  /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
  @cpBitmask()
  external int categories;

  /// A bitmask of user definable category types that this object object collides with.
  /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
  @cpBitmask()
  external int mask;
}

typedef cpGroup = ffi.UintPtr;
typedef cpBitmask = ffi.UnsignedInt;

final class cpArbiterThread extends ffi.Struct {
  external ffi.Pointer<cpArbiter> next;

  external ffi.Pointer<cpArbiter> prev;
}

final class cpContact extends ffi.Opaque {}

abstract class cpArbiterState {
  static const int CP_ARBITER_STATE_FIRST_COLLISION = 0;
  static const int CP_ARBITER_STATE_NORMAL = 1;
  static const int CP_ARBITER_STATE_IGNORE = 2;
  static const int CP_ARBITER_STATE_CACHED = 3;
  static const int CP_ARBITER_STATE_INVALIDATED = 4;
}

typedef cpCollisionPreSolveFuncD = ffi.Pointer<ffi.NativeFunction<cpBool Function(ffi.Pointer<cpArbiter> arb, ffi.Pointer<cpSpace> space, cpDataPointer userData, ffi.Uint64 callbackId)>>;
typedef cpCollisionPostSolveFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter> arb, ffi.Pointer<cpSpace> space, cpDataPointer userData, ffi.Uint64 callbackId)>>;
typedef cpCollisionSeparateFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpArbiter> arb, ffi.Pointer<cpSpace> space, cpDataPointer userData, ffi.Uint64 callbackId)>>;

/// A struct that wraps up the important collision data for an arbiter.
final class cpContactPointSet extends ffi.Struct {
  /// The number of contact points in the set.
  @ffi.Int()
  external int count;

  /// The normal of the collision.
  external cpVect normal;

  @ffi.Array.multi([2])
  external ffi.Array<UnnamedStruct2> points;
}

/// The array of contact points.
final class UnnamedStruct2 extends ffi.Struct {
  /// The position of the contact on the surface of each shape.
  external cpVect pointA;

  external cpVect pointB;

  /// Penetration distance of the two shapes. Overlapping means it will be negative.
  /// This value is calculated as cpvdot(cpvsub(point2, point1), normal) and is ignored by cpArbiterSetContactPointSet().
  @cpFloat()
  external double distance;
}

abstract class cpBodyType {
  /// A dynamic body is one that is affected by gravity, forces, and collisions.
  /// This is the default body type.
  static const int CP_BODY_TYPE_DYNAMIC = 0;

  /// A kinematic body is an infinite mass, user controlled body that is not affected by gravity, forces or collisions.
  /// Instead the body only moves based on it's velocity.
  /// Dynamic bodies collide normally with kinematic bodies, though the kinematic body will be unaffected.
  /// Collisions between two kinematic bodies, or a kinematic body and a static body produce collision callbacks, but no collision response.
  static const int CP_BODY_TYPE_KINEMATIC = 1;

  /// A static body is a body that never (or rarely) moves. If you move a static body, you must call one of the cpSpaceReindex*() functions.
  /// Chipmunk uses this information to optimize the collision detection.
  /// Static bodies do not produce collision callbacks when colliding with other static bodies.
  static const int CP_BODY_TYPE_STATIC = 2;
}

final class cpDampedRotarySpring extends ffi.Struct {
  external cpConstraint constraint;

  @cpFloat()
  external double restAngle;

  @cpFloat()
  external double stiffness;

  @cpFloat()
  external double damping;

  external cpDampedRotarySpringTorqueFuncD springTorqueFunc;

  @cpFloat()
  external double target_wrn;

  @cpFloat()
  external double w_coef;

  @cpFloat()
  external double iSum;

  @cpFloat()
  external double jAcc;

  @ffi.Uint64()
  external int callbackId;
}

typedef cpDampedRotarySpringTorqueFuncD = ffi.Pointer<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint> spring, cpFloat relativeAngle, ffi.Uint64 callbackId)>>;

final class cpGearJoint extends ffi.Struct {
  external cpConstraint constraint;

  @cpFloat()
  external double phase;

  @cpFloat()
  external double ratio;

  @cpFloat()
  external double ratio_inv;

  @cpFloat()
  external double iSum;

  @cpFloat()
  external double bias;

  @cpFloat()
  external double jAcc;
}

final class cpDampedSpring extends ffi.Struct {
  external cpConstraint constraint;

  external cpVect anchorA;

  external cpVect anchorB;

  @cpFloat()
  external double restLength;

  @cpFloat()
  external double stiffness;

  @cpFloat()
  external double damping;

  external cpDampedSpringForceFuncD springForceFunc;

  @cpFloat()
  external double target_vrn;

  @cpFloat()
  external double v_coef;

  external cpVect r1;

  external cpVect r2;

  @cpFloat()
  external double nMass;

  external cpVect n;

  @cpFloat()
  external double jAcc;

  @ffi.Uint64()
  external int callbackId;
}

typedef cpDampedSpringForceFuncD = ffi.Pointer<ffi.NativeFunction<cpFloat Function(ffi.Pointer<cpConstraint> spring, cpFloat dist, ffi.Uint64 callbackId)>>;

final class cpMat2x2 extends ffi.Struct {
  @cpFloat()
  external double a;

  @cpFloat()
  external double b;

  @cpFloat()
  external double c;

  @cpFloat()
  external double d;
}

final class cpPivotJoint extends ffi.Struct {
  external cpConstraint constraint;

  external cpVect anchorA;

  external cpVect anchorB;

  external cpVect r1;

  external cpVect r2;

  external cpMat2x2 k;

  external cpVect jAcc;

  external cpVect bias;
}

final class cpPinJoint extends ffi.Struct {
  external cpConstraint constraint;

  external cpVect anchorA;

  external cpVect anchorB;

  @cpFloat()
  external double dist;

  external cpVect r1;

  external cpVect r2;

  external cpVect n;

  @cpFloat()
  external double nMass;

  @cpFloat()
  external double jnAcc;

  @cpFloat()
  external double bias;
}

final class cpGrooveJoint extends ffi.Struct {
  external cpConstraint constraint;

  external cpVect grv_n;

  external cpVect grv_a;

  external cpVect grv_b;

  external cpVect anchorB;

  external cpVect grv_tn;

  @cpFloat()
  external double clamp;

  external cpVect r1;

  external cpVect r2;

  external cpMat2x2 k;

  external cpVect jAcc;

  external cpVect bias;
}

final class cpSplittingPlane extends ffi.Struct {
  external cpVect v0;

  external cpVect n;
}

final class cpPolyShape extends ffi.Struct {
  external cpShape shape;

  @cpFloat()
  external double r;

  @ffi.Int()
  external int count;

  external ffi.Pointer<cpSplittingPlane> planes;

  @ffi.Array.multi([12])
  external ffi.Array<cpSplittingPlane> _planes;
}

final class cpRotaryLimitJoint extends ffi.Struct {
  external cpConstraint constraint;

  @cpFloat()
  external double min;

  @cpFloat()
  external double max;

  @cpFloat()
  external double iSum;

  @cpFloat()
  external double bias;

  @cpFloat()
  external double jAcc;
}

final class cpRatchetJoint extends ffi.Struct {
  external cpConstraint constraint;

  @cpFloat()
  external double angle;

  @cpFloat()
  external double phase;

  @cpFloat()
  external double ratchet;

  @cpFloat()
  external double iSum;

  @cpFloat()
  external double bias;

  @cpFloat()
  external double jAcc;
}

final class cpSlideJoint extends ffi.Struct {
  external cpConstraint constraint;

  external cpVect anchorA;

  external cpVect anchorB;

  @cpFloat()
  external double min;

  @cpFloat()
  external double max;

  external cpVect r1;

  external cpVect r2;

  external cpVect n;

  @cpFloat()
  external double nMass;

  @cpFloat()
  external double jnAcc;

  @cpFloat()
  external double bias;
}

final class cpCircleShape extends ffi.Struct {
  external cpShape shape;

  external cpVect c;

  external cpVect tc;

  @cpFloat()
  external double r;
}

final class cpSegmentShape extends ffi.Struct {
  external cpShape shape;

  external cpVect a;

  external cpVect b;

  external cpVect n;

  external cpVect ta;

  external cpVect tb;

  external cpVect tn;

  @cpFloat()
  external double r;

  external cpVect a_tangent;

  external cpVect b_tangent;
}

final class cpSimpleMotor extends ffi.Struct {
  external cpConstraint constraint;

  @cpFloat()
  external double rate;

  @cpFloat()
  external double iSum;

  @cpFloat()
  external double jAcc;
}

/// Color type to use with the space debug drawing API.
final class cpSpaceDebugColor extends ffi.Struct {
  @ffi.Float()
  external double r;

  @ffi.Float()
  external double g;

  @ffi.Float()
  external double b;

  @ffi.Float()
  external double a;
}

abstract class cpSpaceDebugDrawFlags {
  static const int CP_SPACE_DEBUG_DRAW_SHAPES = 1;
  static const int CP_SPACE_DEBUG_DRAW_CONSTRAINTS = 2;
  static const int CP_SPACE_DEBUG_DRAW_COLLISION_POINTS = 4;
}

/// Struct used with cpSpaceDebugDraw() containing drawing callbacks and other drawing settings.
final class cpSpaceDebugDrawOptions extends ffi.Struct {
  /// Function that will be invoked to draw circles.
  external cpSpaceDebugDrawCircleImpl drawCircle;

  /// Function that will be invoked to draw line segments.
  external cpSpaceDebugDrawSegmentImpl drawSegment;

  /// Function that will be invoked to draw thick line segments.
  external cpSpaceDebugDrawFatSegmentImpl drawFatSegment;

  /// Function that will be invoked to draw convex polygons.
  external cpSpaceDebugDrawPolygonImpl drawPolygon;

  /// Function that will be invoked to draw dots.
  external cpSpaceDebugDrawDotImpl drawDot;

  /// Flags that request which things to draw (collision shapes, constraints, contact points).
  @ffi.Int32()
  external int flags;

  /// Outline color passed to the drawing function.
  external cpSpaceDebugColor shapeOutlineColor;

  /// Function that decides what fill color to draw shapes using.
  external cpSpaceDebugDrawColorForShapeImpl colorForShape;

  /// Color passed to drawing functions for constraints.
  external cpSpaceDebugColor constraintColor;

  /// Color passed to drawing functions for collision points.
  external cpSpaceDebugColor collisionPointColor;

  /// User defined context pointer passed to all of the callback functions as the 'data' argument.
  external cpDataPointer data;
}

/// Callback type for a function that draws a filled, stroked circle.
typedef cpSpaceDebugDrawCircleImpl
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(cpVect pos, cpFloat angle, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data)>>;

/// Callback type for a function that draws a line segment.
typedef cpSpaceDebugDrawSegmentImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(cpVect a, cpVect b, cpSpaceDebugColor color, cpDataPointer data)>>;

/// Callback type for a function that draws a thick line segment.
typedef cpSpaceDebugDrawFatSegmentImpl
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(cpVect a, cpVect b, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data)>>;

/// Callback type for a function that draws a convex polygon.
typedef cpSpaceDebugDrawPolygonImpl
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Int count, ffi.Pointer<cpVect> verts, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data)>>;

/// Callback type for a function that draws a dot.
typedef cpSpaceDebugDrawDotImpl = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(cpFloat size, cpVect pos, cpSpaceDebugColor color, cpDataPointer data)>>;

/// Callback type for a function that returns a color for a given shape. This gives you an opportunity to color shapes based on how they are used in your engine.
typedef cpSpaceDebugDrawColorForShapeImpl = ffi.Pointer<ffi.NativeFunction<cpSpaceDebugColor Function(ffi.Pointer<cpShape> shape, cpDataPointer data)>>;

final class cpSpaceHash extends ffi.Opaque {}

final class cpBBTree extends ffi.Opaque {}

final class cpSweep1D extends ffi.Opaque {}

final class cpPolyline extends ffi.Opaque {}

final class cpPolylineSet extends ffi.Struct {
  @ffi.Int()
  external int count;

  @ffi.Int()
  external int capacity;

  external ffi.Pointer<ffi.Pointer<cpPolyline>> lines;
}

typedef cpBodyShapeIteratorFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, ffi.Pointer<cpShape> shape, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpBodyConstraintIteratorFuncD
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, ffi.Pointer<cpConstraint> constraint, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;

typedef cpBodyArbiterIteratorFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, ffi.Pointer<cpArbiter> arbiter, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpPostStepFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpSpace> space, ffi.Pointer<ffi.Void> key, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpacePointQueryFuncD
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, cpVect point, cpFloat distance, cpVect gradient, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceBBQueryFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceSegmentQueryFuncD
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, cpVect point, cpVect normal, cpFloat alpha, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceShapeQueryFuncD
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, ffi.Pointer<cpContactPointSet> points, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceShapeIteratorFunc = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, ffi.Pointer<ffi.Void> data)>>;
typedef cpSpaceBodyIteratorFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpBody> body, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceShapeIteratorFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpShape> shape, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpSpaceConstraintIteratorFuncD = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<cpConstraint> constraint, ffi.Pointer<ffi.Void> data, ffi.Uint64 callbackId)>>;
typedef cpBBTreeVelocityFunc = ffi.Pointer<ffi.NativeFunction<cpVect Function(ffi.Pointer<ffi.Void> obj)>>;

const int CP_MAX_CONTACTS_PER_ARBITER = 2;

const int CP_POLY_SHAPE_INLINE_ALLOC = 6;
