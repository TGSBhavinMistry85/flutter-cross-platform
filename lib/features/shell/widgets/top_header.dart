import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/routing/app_routes.dart';
import 'package:flutter_application_1/core/services/session_service.dart';
import 'package:flutter_application_1/features/shell/logic/side_menu_controller.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ☰ Menu icon
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: SideMenuController.toggle,
          ),

          const SizedBox(width: 8),
          
          Text(
            'Welcome, ${SessionService.currentUser?.name ?? ''}',
            style: const TextStyle(color: Colors.white),
          ),
          
          TextButton(
            onPressed: () {
              SessionService.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}