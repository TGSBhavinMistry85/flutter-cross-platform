import 'package:flutter/material.dart';

/// Tile data coming from API / Controller
class StatsTileModel {
  final String title;
  final int value;
  final IconData icon;
  final Color color;
  final int sequenceOrder;

  StatsTileModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.sequenceOrder,
  });
}

/// Reusable statistics tiles widget
class StatisticsTiles extends StatelessWidget {
  final List<StatsTileModel> tiles;

  /// Control tile sizing
  final double minTileWidth;
  final double maxTileWidth;

  const StatisticsTiles({
    super.key,
    required this.tiles,
    this.minTileWidth = 220,
    this.maxTileWidth = 320,
  });

  @override
  Widget build(BuildContext context) {
    final sortedTiles = [...tiles]
      ..sort((a, b) => a.sequenceOrder.compareTo(b.sequenceOrder));

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: sortedTiles.map((tile) {
            final double tileWidth =
                _calculateTileWidth(constraints.maxWidth);

            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minTileWidth,
                maxWidth: maxTileWidth,
              ),
              child: SizedBox(
                width: tileWidth,
                child: _StatsTile(tile: tile),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  double _calculateTileWidth(double availableWidth) {
    // Try to fit as many tiles as possible without exceeding max width
    int count = (availableWidth / maxTileWidth).floor();
    count = count < 1 ? 1 : count;

    final double width = availableWidth / count;
    return width.clamp(minTileWidth, maxTileWidth);
  }
}

/// Individual tile UI
class _StatsTile extends StatelessWidget {
  final StatsTileModel tile;

  const _StatsTile({required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tile.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: tile.color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tile.icon,
              color: tile.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tile.value.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tile.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}