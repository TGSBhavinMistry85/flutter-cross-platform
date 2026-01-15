import '../model/employee_list_model.dart';

class EmployeeController {
  EmployeeController._();

  /// Dummy employee list (temporary – replace with API later)
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
}