class ManageEmployeeModel {
  final BigInt? employeeId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String? phone;
  final DateTime? dateOfBirth;
  final String gender;
  final BigInt departmentId;
  final String address;
  final BigInt countryId;
  final BigInt stateId;
  final String zipcode;
  final List<String> languages;
  final List<String> hobbies;

  ManageEmployeeModel({
    this.employeeId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    this.phone,
    this.dateOfBirth,
    required this.gender,
    required this.departmentId,
    required this.address,
    required this.countryId,
    required this.stateId,
    required this.zipcode,
    required this.languages,
    required this.hobbies,
  });

  // -------------------- TO JSON --------------------

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId?.toString(), // BigInt → String
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'departmentId': departmentId.toString(),
      'address': address,
      'countryId': countryId.toString(),
      'stateId': stateId.toString(),
      'zipcode': zipcode,
      'languages': languages,
      'hobbies': hobbies,
    };
  }

  // -------------------- FROM JSON --------------------

  factory ManageEmployeeModel.fromJson(Map<String, dynamic> json) {
    return ManageEmployeeModel(
      employeeId: json['employeeId'] != null
          ? BigInt.parse(json['employeeId'])
          : null,
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'],
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'] ?? '',
      departmentId: BigInt.parse(json['departmentId']),
      address: json['address'] ?? '',
      countryId: BigInt.parse(json['countryId']),
      stateId: BigInt.parse(json['stateId']),
      zipcode: json['zipcode'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      hobbies: List<String>.from(json['hobbies'] ?? []),
    );
  }

  // -------------------- DEBUG --------------------

  @override
  String toString() {
    return '''
      ManageEmployeeModel(
        employeeId: $employeeId,
        firstName: $firstName,
        middleName: $middleName,
        lastName: $lastName,
        email: $email,
        phone: $phone,
        dateOfBirth: $dateOfBirth,
        gender: $gender,
        departmentId: $departmentId,
        address: $address,
        countryId: $countryId,
        stateId: $stateId,
        zipcode: $zipcode,
        languages: $languages,
        hobbies: $hobbies
      )
      ''';
  }
}