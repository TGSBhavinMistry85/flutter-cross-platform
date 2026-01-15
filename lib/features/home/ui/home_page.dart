import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_application_1/features/home/logic/home_controller.dart';
import 'package:flutter_application_1/shared/widgets/statistics_card.dart';
import 'package:flutter_application_1/shared/widgets/color_analysis_linechart.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          const SizedBox(height: 24),

          /// =======================
          /// Line Chart
          /// =======================
          LineChartWidget(
            title: "Color Analysis",
            maxY: 6.0,
            yInterval: 0.2,
            legends: [
              LegendItem("Wave1", Colors.blue),
              LegendItem("Wave2", Colors.red),
              LegendItem("Diff", Colors.yellow),
            ],
            lines: [
              LineChartBarData(
                spots: [
                  FlSpot(300, 0.0),
                  FlSpot(400, 4.5),
                  FlSpot(500, 4.0),
                  FlSpot(600, 3.8),
                  FlSpot(700, 5.8),
                  FlSpot(800, 3.0),
                  FlSpot(900, 2.5),
                ],
                color: Colors.blue,
                barWidth: 2,
                isCurved: true,
              ),
              LineChartBarData(
                spots: [
                  FlSpot(300, 0.0),
                  FlSpot(400, 3.0),
                  FlSpot(500, 2.8),
                  FlSpot(600, 2.5),
                  FlSpot(700, 4.0),
                  FlSpot(800, 2.2),
                  FlSpot(900, 1.5),
                ],
                color: Colors.red,
                barWidth: 2,
                isCurved: true,
              ),
              LineChartBarData(
                spots: [
                  FlSpot(300, 0.0),
                  FlSpot(400, 1.5),
                  FlSpot(500, 1.2),
                  FlSpot(600, 1.3),
                  FlSpot(700, 1.8),
                  FlSpot(800, 0.8),
                  FlSpot(900, 1.0),
                ],
                color: Colors.yellow,
                barWidth: 2,
                isCurved: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}