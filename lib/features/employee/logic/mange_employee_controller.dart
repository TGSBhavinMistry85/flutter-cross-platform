import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

  List<String> languages = [];
  List<String> hobbies = [];
  List<String> days = [];

  /// Snapshot for dirty check
  ManageEmployeeModel? _initialModel;

  void initForAdd() {
    _initialModel = ManageEmployeeModel(
      employeeId: null,
      firstName: '',
      middleName: '',
      lastName: '',
      email: '',
      phone: '',
      gender: '',
      address: '',
      zipcode: '',
      departmentId: BigInt.zero,
      countryId: BigInt.zero,
      stateId: BigInt.zero,
      languages: [],
      hobbies: [],
      dateOfBirth: null,
    );
  }

  void loadForEdit(BigInt employeeId) {
    // Dummy data (replace with API later)
    final emp = ManageEmployeeModel(
      employeeId: employeeId,
      firstName: 'John',
      middleName: 'A',
      lastName: 'Doe',
      email: 'john.doe@test.com',
      phone: '9999999999',
      gender: 'M',
      departmentId: BigInt.from(1),
      address: 'Ahmedabad',
      countryId: BigInt.from(1),
      stateId: BigInt.from(1),
      zipcode: '380015',
      languages: ['English', 'Hindi'],
      hobbies: ['Reading', 'Cricket'],
    );

    _fillFromModel(emp);
    _initialModel = emp;
  }

  void markSaved() {
    _initialModel = buildModel(employeeId: _initialModel?.employeeId);
  }

  // ---------------- Build Model ----------------

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
      hobbies: hobbies,
      languages: languages,
    );
  }

  // ---------------- Dirty Check ----------------

  bool get isDirty {
    if (_initialModel == null) return false;

    return !mapEquals(
      buildModel(employeeId: _initialModel!.employeeId).toJson(),
      _initialModel!.toJson(),
    );
  }

  // ---------------- Helpers ----------------

  void _fillFromModel(ManageEmployeeModel emp) {
    firstNameCtrl.text = emp.firstName;
    middleNameCtrl.text = emp.middleName ?? '';
    lastNameCtrl.text = emp.lastName;
    emailCtrl.text = emp.email;
    phoneCtrl.text = emp.phone ?? '';
    zipcodeCtrl.text = emp.zipcode;
    addressCtrl.text = emp.address;

    dob = emp.dateOfBirth;
    gender = emp.gender;
    departmentId = emp.departmentId.toInt();
    countryId = emp.countryId.toInt();
    stateId = emp.stateId.toInt();

    languages = List.from(emp.languages);
    hobbies = List.from(emp.hobbies);
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
