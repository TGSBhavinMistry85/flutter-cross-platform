class ManageEmployeeModel {
  BigInt? employeeId;

  String firstName;
  String? middleName;
  String lastName;
  String email;
  String? phone;
  DateTime? dateOfBirth;
  String gender;
  BigInt departmentId;
  String address;
  BigInt countryId;
  BigInt stateId;
  String zipcode;

  List<String> languages;
  List<String> hobbies;

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

  factory ManageEmployeeModel.empty() => ManageEmployeeModel(
        firstName: '',
        lastName: '',
        email: '',
        gender: '',
        departmentId: BigInt.zero,
        address: '',
        countryId: BigInt.zero,
        stateId: BigInt.zero,
        zipcode: '',
        languages: [],
        hobbies: [],
      );
}