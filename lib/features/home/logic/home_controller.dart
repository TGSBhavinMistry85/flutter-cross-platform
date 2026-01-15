import 'package:flutter/foundation.dart';

import 'package:flutter_application_1/features/home/model/home_stats.dart';

class HomeController {
  HomeController._();

  static final ValueNotifier<HomeStats> departmentStats =
      ValueNotifier<HomeStats>(HomeStats.empty());

  static final ValueNotifier<HomeStats> employeeStats =
      ValueNotifier<HomeStats>(HomeStats.empty());

  /// Call this from UI (initState)
  static Future<void> loadStats() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Replace with API response later
    departmentStats.value = const HomeStats(
      total: 0,
      active: 0,
      inactive: 0,
      deleted: 0,
    );

    employeeStats.value = const HomeStats(
      total: 0,
      active: 0,
      inactive: 0,
      deleted: 0,
    );
  }
}