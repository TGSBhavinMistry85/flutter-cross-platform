import 'package:flutter/material.dart';
import '../model/employee_model.dart';

class ManageEmployeeController {
  final formKey = GlobalKey<FormState>();

  final firstNameCtrl = TextEditingController();
  final middleNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final zipcodeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  int? departmentId;
  int? countryId;
  int? stateId;

  DateTime? dob;
  String? gender;

  void loadForEdit(BigInt employeeId) {
    // Dummy data (replace with API later)
    firstNameCtrl.text = 'John';
    middleNameCtrl.text = 'M';
    lastNameCtrl.text = 'Doe';
    emailCtrl.text = 'john.doe@mail.com';
    phoneCtrl.text = '9876543210';
    zipcodeCtrl.text = '380015';
    addressCtrl.text = 'Ahmedabad, Gujarat';
    gender = 'Male';
    dob = DateTime(1995, 5, 20);
    departmentId = 1;
    countryId = 1;
    stateId = 1;
  }

  ManageEmployeeModel buildModel({BigInt? employeeId}) {
    return ManageEmployeeModel(
      employeeId: employeeId,
      firstName: firstNameCtrl.text.trim(),
      middleName: middleNameCtrl.text.trim(),
      lastName: lastNameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      dateOfBirth: dob,
      gender: gender ?? 'Male',
      address: addressCtrl.text.trim(),
      zipcode: zipcodeCtrl.text.trim(),
      departmentId: BigInt.from(departmentId!),
      countryId: BigInt.from(countryId!),
      stateId: BigInt.from(stateId!),
      hobbies: ['cricket'],
      languages: ['English', 'Hindi']
    );
  }

  void dispose() {
    firstNameCtrl.dispose();
    middleNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    zipcodeCtrl.dispose();
    addressCtrl.dispose();
  }
}
