import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/home/ui/home_page.dart';
import 'package:flutter_application_1/features/department/ui/department_page.dart';
import 'package:flutter_application_1/features/employee/ui/employee_page.dart';
import 'package:flutter_application_1/features/shell/logic/main_content_controller.dart';
import 'package:flutter_application_1/features/shell/logic/side_menu_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SideMenuController.isOpen,
      builder: (_, isOpen, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isOpen ? 240 : 72,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: Color(0xFFE5E7EB)),
            ),
          ),
          child: Column(
            children: [
              _logoHeader(isOpen),
              const SizedBox(height: 8),

              _menuItem(
                icon: Icons.dashboard_outlined,
                title: 'Dashboard',
                index: 0,
                page: const HomePage(),
                isOpen: isOpen,
              ),
              _menuItem(
                icon: Icons.analytics_outlined,
                title: 'Department',
                index: 1,
                page: const DepartmentPage(),
                isOpen: isOpen,
              ),
              _menuItem(
                icon: Icons.receipt_long_outlined,
                title: 'Employee',
                index: 2,
                page: const EmployeePage(),
                isOpen: isOpen,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _logoHeader(bool isOpen) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // Logo icon
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.bubble_chart,
              color: Color(0xFF6366F1),
            ),
          ),

          if (isOpen) ...[
            const SizedBox(width: 10),
            const Text(
              'TRIVENI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
          ]
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required int index,
    required Widget page,
    required bool isOpen,
  }) {
    return ValueListenableBuilder<int>(
      valueListenable: SideMenuController.selectedIndex,
      builder: (_, selected, __) {
        final isActive = selected == index;

        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            SideMenuController.selectedIndex.value = index;
            MainContentController.open(page);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFEDE9FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isActive
                      ? const Color(0xFF6366F1)
                      : Colors.grey.shade700,
                ),
                if (isOpen) ...[
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

}