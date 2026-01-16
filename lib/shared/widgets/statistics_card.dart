import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/features/home/model/home_stats.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final ValueListenable<HomeStats> statsListenable;

  const StatsCard({super.key, 
    required this.title,
    required this.statsListenable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<HomeStats>(
          valueListenable: statsListenable,
          builder: (_, stats, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _statRow('Total Records', stats.total),
                _statRow('Active', stats.active),
                _statRow('Inactive', stats.inactive),
                _statRow('Deleted', stats.deleted),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _statRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}