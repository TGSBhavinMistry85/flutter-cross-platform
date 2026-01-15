import 'package:flutter/material.dart';

class MainContentController {
  MainContentController._(); // private constructor

  /// Holds the currently selected page in the main content area
  static final ValueNotifier<Widget> currentPage =
      ValueNotifier<Widget>(const SizedBox());

  /// Open a page in the main content area
  static void open(Widget page) {
    currentPage.value = page;
  }
}