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
          duration: const Duration(milliseconds: 200),
          width: isOpen ? 220 : 60,
          color: Colors.grey.shade200,
          child: Column(
            children: [
               _menuItem(
                icon: Icons.home,
                title: 'Dashboard',
                page: const HomePage(),
                isOpen: isOpen,
              ),
              _menuItem(
                icon: Icons.apartment,
                title: 'Department',
                page: const DepartmentPage(),
                isOpen: isOpen,
              ),
              _menuItem(
                icon: Icons.people,
                title: 'Employee',
                page: const EmployeePage(),
                isOpen: isOpen,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required Widget page,
    required bool isOpen,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: isOpen ? Text(title) : null,
      onTap: () => MainContentController.open(page),
    );
  }
}