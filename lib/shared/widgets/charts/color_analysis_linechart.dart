import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final String title;
  final List<LineChartBarData> lines;
  final List<LegendItem> legends;
  final double maxY;
  final double yInterval;

  const LineChartWidget({
    super.key,
    required this.title,
    required this.lines,
    required this.legends,
    this.maxY = 6.0,
    this.yInterval = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// =======================
            /// Header (Title + Legend)
            /// =======================
            Row(
              children: [
                /// Top Left Title
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                /// Top Center Legend
                Row(
                  children: legends
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                color: e.color,
                              ),
                              const SizedBox(width: 6),
                              Text(e.label),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// =======================
            /// Line Chart
            /// =======================
            SizedBox(
              height: 400,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,

                  /// Lines
                  lineBarsData: lines,

                  /// Grid
                  gridData: FlGridData(show: true),

                  /// Borders
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide.none,
                      top: BorderSide.none,
                    ),
                  ),

                  /// Axis Titles
                  titlesData: FlTitlesData(
                    /// LEFT (Y-axis)
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: yInterval,
                        getTitlesWidget: (value, meta) => Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),

                    /// BOTTOM (X-axis)
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Length',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      axisNameSize: 28,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),

                    /// REMOVE TOP & RIGHT
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// Legend Model
/// =======================
class LegendItem {
  final String label;
  final Color color;

  LegendItem(this.label, this.color);
}