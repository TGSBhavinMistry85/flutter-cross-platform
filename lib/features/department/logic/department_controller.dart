import 'package:flutter/foundation.dart';

import 'package:flutter_application_1/features/department/model/department_stats.dart';

class DepartmentController {
  DepartmentController._();

  static final ValueNotifier<DepartmentStats> departmentStats =
      ValueNotifier<DepartmentStats>(DepartmentStats.empty());

  /// Call this from UI (initState)
  static Future<void> loadStats() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Replace with API response later
    departmentStats.value = const DepartmentStats(
      total: 0,
      active: 0,
      inactive: 0,
      deleted: 0,
    );
  }
}