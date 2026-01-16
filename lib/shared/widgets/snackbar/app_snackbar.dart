import 'package:flutter/material.dart';

/// ===============================
/// ENUMS
/// ===============================

enum SnackBarType {
  success,
  warning,
  error,
  info,
}

enum SnackBarPosition {
  topCenter,
  topRight,
  bottomCenter,
  bottomRight,
}

/// ===============================
/// APP SNACKBAR (OVERLAY BASED)
/// ===============================

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    SnackBarPosition position = SnackBarPosition.topRight,
    double width = 350,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: _isTop(position) ? 24 : null,
          bottom: _isBottom(position) ? 24 : null,
          left: _isCenter(position)
              ? MediaQuery.of(context).size.width / 2 - width / 2
              : null,
          right: _isRight(position) ? 24 : null,
          child: Material(
            color: Colors.transparent,
            child: _SnackBarWidget(
              message: message,
              type: type,
              width: width,
            ),
          ),
        );
      },
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      entry.remove();
    });
  }

  static bool _isTop(SnackBarPosition p) =>
      p == SnackBarPosition.topCenter ||
      p == SnackBarPosition.topRight;

  static bool _isBottom(SnackBarPosition p) =>
      p == SnackBarPosition.bottomCenter ||
      p == SnackBarPosition.bottomRight;

  static bool _isCenter(SnackBarPosition p) =>
      p == SnackBarPosition.topCenter ||
      p == SnackBarPosition.bottomCenter;

  static bool _isRight(SnackBarPosition p) =>
      p == SnackBarPosition.topRight ||
      p == SnackBarPosition.bottomRight;
}

/// ===============================
/// SNACKBAR UI
/// ===============================

class _SnackBarWidget extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final double width;

  const _SnackBarWidget({
    required this.message,
    required this.type,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _backgroundColor(type),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(_icon(type), color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _backgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
        return Colors.blue;
    }
  }

  IconData _icon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}