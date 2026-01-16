import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/department/logic/department_controller.dart';
import 'package:flutter_application_1/shared/widgets/statistics_tiles.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  void initState() {
    super.initState();
    DepartmentController.loadStats();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Departments',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          /// =======================
          /// DASHBOARD TILES (FIXED)
          /// =======================
          SizedBox(
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: DepartmentController.departmentStats,
              builder: (_, deptStats, __) {
                return StatisticsTiles(
                  tiles: [
                    StatsTileModel(
                      title: 'Total Departments',
                      value: deptStats.total,
                      icon: Icons.apartment,
                      color: Colors.orange,
                      sequenceOrder: 1,
                    ),
                    StatsTileModel(
                      title: 'Active Departments',
                      value: deptStats.active,
                      icon: Icons.check_circle,
                      color: Colors.green,
                      sequenceOrder: 2,
                    ),
                    StatsTileModel(
                      title: 'Inactive Departments',
                      value: deptStats.inactive,
                      icon: Icons.cancel,
                      color: Colors.blue,
                      sequenceOrder: 3,
                    ),
                    StatsTileModel(
                      title: 'Deleted Departments',
                      value: deptStats.deleted,
                      icon: Icons.highlight_off,
                      color: Colors.redAccent,
                      sequenceOrder: 4,
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Toolbar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Department'),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Data table
          Expanded(
            child: Card(
              elevation: 2,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Actions')),
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Department Name')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: List.generate(5, (index) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text('${index + 1}')),
                        DataCell(Text('Department ${index + 1}')),
                        const DataCell(Text('Active')),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
