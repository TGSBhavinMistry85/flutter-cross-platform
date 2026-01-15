import 'package:flutter/foundation.dart';

class SideMenuController {
  SideMenuController._();

  /// true = open, false = collapsed
  static final ValueNotifier<bool> isOpen = ValueNotifier<bool>(true);

  static final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  static void toggle() {
    isOpen.value = !isOpen.value;
  }
}