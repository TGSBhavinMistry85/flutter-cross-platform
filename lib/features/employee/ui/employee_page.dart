import 'package:flutter/material.dart';

import '../logic/employee_controller.dart';
import '../model/employee_list_model.dart';
import 'manage_employee_page.dart';
import 'package:flutter_application_1/shared/widgets/confirmation_dialog.dart';
import 'package:flutter_application_1/shared/widgets/app_snackbar.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EmployeeModel> employees = EmployeeController.getEmployees();

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ManageEmployeePage(isEditMode: false),
                    ),
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
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: employees.map((employee) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${employee.employeeId}')),
                        DataCell(
                          Text('${employee.firstName} ${employee.lastName}'),
                        ),
                        DataCell(Text('Department ${employee.departmentId}')),
                        DataCell(Text(employee.email)),
                        const DataCell(Text('Active')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ManageEmployeePage(
                                        isEditMode: true,
                                        employeeId: employee.employeeId,
                                      ),
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
                                  final confirmed = await ConfirmDialog.show(
                                    context: context,
                                    title: 'Delete Employee',
                                    message: 'Are you sure you want to delete ${employee.firstName} ${employee.lastName}?',
                                    confirmText: 'Delete',
                                  );

                                  if (confirmed == true) {
                                    // SOFT DELETE LOGIC (later API)
                                    debugPrint('Soft deleted employee ${employee.employeeId}',);
                                    AppSnackBar.show(
                                      context,
                                      message:'Employee ${employee.firstName} ${employee.lastName} deleted successfully',
                                      type: SnackBarType.success,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
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