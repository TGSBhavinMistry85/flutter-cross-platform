import 'package:flutter/material.dart';

import '../../shell/logic/main_content_controller.dart';
import '../logic/employee_controller.dart';
import '../model/employee_list_model.dart';
import 'manage_employee_page.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  late List<EmployeeModel> employees;

  @override
  void initState() {
    super.initState();
    employees = EmployeeController.getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Employees',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Toolbar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  MainContentController.open(
                    ManageEmployeePage(isEditMode: false),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Add Employee'),
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
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: employees.map((employee) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () {
                                  MainContentController.open(
                                    ManageEmployeePage(
                                      isEditMode: true,
                                      employeeId: employee.employeeId,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                tooltip: 'Delete',
                                onPressed: () async {
                                  // Call controller to handle deletion & snackbar
                                  await EmployeeController.deleteEmployee(
                                    context,
                                    employee,
                                  );

                                  // Optional: remove employee from list locally
                                  if (!mounted) return;
                                  setState(() {
                                    employees.remove(employee);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text('${employee.employeeId}')),
                        DataCell(
                          Text('${employee.firstName} ${employee.lastName}'),
                        ),
                        DataCell(Text('Department ${employee.departmentId}')),
                        DataCell(Text(employee.email)),
                        const DataCell(Text('Active')),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
