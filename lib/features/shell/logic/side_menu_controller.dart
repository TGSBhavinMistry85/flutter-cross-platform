import 'package:flutter/foundation.dart';

class SideMenuController {
  SideMenuController._();

  /// true = open, false = collapsed
  static final ValueNotifier<bool> isOpen =
      ValueNotifier<bool>(true);

  static void toggle() {
    isOpen.value = !isOpen.value;
  }
}