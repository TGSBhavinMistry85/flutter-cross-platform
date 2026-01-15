import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/home/logic/home_controller.dart';
import 'package:flutter_application_1/shared/widgets/statistics_card.dart';
import 'package:flutter_application_1/shared/widgets/statistics_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    HomeController.loadStats();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// =======================
          /// DASHBOARD TILES (FIXED)
          /// =======================
          SizedBox(
            width: double.infinity, // ✅ IMPORTANT
            child: ValueListenableBuilder(
              valueListenable: HomeController.departmentStats,
              builder: (_, deptStats, __) {
                return ValueListenableBuilder(
                  valueListenable: HomeController.employeeStats,
                  builder: (_, empStats, __) {
                    return StatisticsTiles(
                      tiles: [
                        StatsTileModel(
                          title: 'Total Departments',
                          value: deptStats.total,
                          icon: Icons.apartment,
                          color: Colors.orange,
                          sequenceOrder: 1,
                        ),
                        StatsTileModel(
                          title: 'Active Departments',
                          value: deptStats.active,
                          icon: Icons.check_circle,
                          color: Colors.green,
                          sequenceOrder: 2,
                        ),
                        StatsTileModel(
                          title: 'Total Employees',
                          value: empStats.total,
                          icon: Icons.people,
                          color: Colors.blue,
                          sequenceOrder: 3,
                        ),
                        StatsTileModel(
                          title: 'Active Employees',
                          value: empStats.active,
                          icon: Icons.person,
                          color: Colors.teal,
                          sequenceOrder: 4,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          /// =======================
          /// DETAIL CARDS
          /// =======================
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Department Statistics',
                  statsListenable: HomeController.departmentStats,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatsCard(
                  title: 'Employee Statistics',
                  statsListenable: HomeController.employeeStats,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}