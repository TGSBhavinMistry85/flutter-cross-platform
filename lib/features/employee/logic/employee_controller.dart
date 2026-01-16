import 'package:flutter/material.dart';
import '../model/employee_list_model.dart';
import 'package:flutter_application_1/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter_application_1/shared/widgets/dialogs/confirmation_dialog.dart';

class EmployeeController {
  EmployeeController._();

  static List<EmployeeModel> getEmployees() {
    return List.generate(8, (index) {
      return EmployeeModel(
        employeeId: BigInt.from(index + 1),
        firstName: 'Employee',
        middleName: '',
        lastName: '${index + 1}',
        email: 'emp${index + 1}@company.com',
        phone: '9999999999',
        gender: 'M',
        departmentId: BigInt.from((index % 3) + 1),
        address: 'Sample Address',
        countryId: BigInt.one,
        stateId: BigInt.one,
        zipcode: '380001',
        languages: const ['English'],
        hobbies: const ['Reading'],
      );
    });
  }

  static Future<void> deleteEmployee(
    BuildContext context,
    EmployeeModel employee,
  ) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete Employee',
      message:
          'Are you sure you want to delete ${employee.firstName} ${employee.lastName}?',
      confirmText: 'Delete',
    );

    if (confirmed != true) return;

    // Replace with soft-delete API
    debugPrint('Soft deleted employee ${employee.employeeId}');

    // ✅ Safe snackbar
    if (!context.mounted) return;

    AppSnackBar.show(
      context,
      message:
          'Employee ${employee.firstName} ${employee.lastName} deleted successfully',
      type: SnackBarType.success,
    );
  }
}