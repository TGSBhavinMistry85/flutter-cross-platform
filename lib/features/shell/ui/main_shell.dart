import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/shell/logic/main_content_controller.dart';
import 'package:flutter_application_1/features/shell/widgets/top_header.dart';
import 'package:flutter_application_1/features/shell/widgets/side_menu.dart';
import 'package:flutter_application_1/features/home/ui/home_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    // Default page
    MainContentController.open(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Column(
              children: [
                const TopHeader(),
                Expanded(
                  child: ValueListenableBuilder<Widget>(
                    valueListenable:
                        MainContentController.currentPage,
                    builder: (_, page, __) => page,
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