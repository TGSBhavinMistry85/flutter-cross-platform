import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/routing/app_routes.dart';
import 'package:flutter_application_1/core/services/session_service.dart';
import 'package:flutter_application_1/features/shell/logic/side_menu_controller.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = SessionService.currentUser?.name ?? 'User';

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LEFT: Menu + Welcome
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: SideMenuController.toggle,
              ),

              const SizedBox(width: 10), // 👈 exactly 10px spacing

              Text(
                'Welcome, $userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          /// RIGHT: Profile dropdown
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  //Navigator.pushNamed(context, AppRoutes.profile);
                  break;
                case 'logout':
                  SessionService.logout();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                  break;
              }
            },
            offset: const Offset(0, 50),
            color: Colors.white,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 18),
                    SizedBox(width: 8),
                    Text('My Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  userName.isNotEmpty ? userName : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}