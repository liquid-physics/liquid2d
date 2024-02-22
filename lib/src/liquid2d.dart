// ignore_for_file: non_constant_identifier_names, unused_element

library liquid2d;

import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:uuid/uuid.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:ffi/ffi.dart';

import 'bindings.dart';
import 'extension.dart';

part 'body.dart';
part 'helper.dart';
part 'constraint.dart';
part 'shape.dart';
part 'space.dart';
part 'collision.dart';
part 'arbiter.dart';
part 'debug.dart';

const String _libName = 'chipmunk';

/// The dynamic library in which the symbols for [liquid2dBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final Chipmunks bindings = Chipmunks(_dylib);
var uuid = const Uuid();

abstract class liquid2d {
  liquid2d();
  // liquid2d _fromPointerCast(
  //   Pointer<Void> p,
  // ) {
  //   if (T is Space) {
  //     return Space._fromPointer(p.cast<cpSpace>());
  //   } else if (T is Shape) {
  //     return Shape._fromPointer(p.cast<cpShape>());
  //   } else if (T is Constraint) {
  //     return Constraint._fromPointer(p.cast<cpConstraint>());
  //   } else if (T is Body) {
  //     return Body._fromPointer(p.cast<cpBody>());
  //   } else {
  //     throw 'error type';
  //   }
  // }
}
