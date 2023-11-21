// import 'package:vector_math/vector_math_64.dart';

// class MouseEvent {
//   static Vector2 mouseToSpace(
//       {required double width,
//       required double height,
//       required double dx,
//       required double dy}) {
//     var clipCoord = Vector2(2 * dx / width - 1, 1 - 2 * dy / height);
//   }
// }

import 'package:flutter/services.dart';

class InputEvent {
  final bool Function(KeyEvent) event;
  InputEvent(this.event) {
    ServicesBinding.instance.keyboard.addHandler(event);
  }
  // bool _onKey(KeyEvent event) {
  //   final key = event.logicalKey.keyLabel;

  //   if (event is KeyDownEvent) {
  //     if (event.logicalKey  == LogicalKeyboardKey.keyA) {

  //     }
  //   } else if (event is KeyUpEvent) {
  //     print("Key up: $key");
  //   } else if (event is KeyRepeatEvent) {
  //     print("Key repeat: $key");
  //   }

  //   return false;
  // }

  void destroy() {
    ServicesBinding.instance.keyboard.removeHandler(event);
  }
}
