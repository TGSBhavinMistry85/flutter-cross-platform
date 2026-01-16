import 'package:flutter/material.dart';

import '../../shell/logic/main_content_controller.dart';
import '../logic/mange_employee_controller.dart';
import '../model/employee_model.dart';

import 'package:flutter_application_1/features/employee/ui/employee_page.dart';
import 'package:flutter_application_1/shared/widgets/custom_widgets.dart';

class ManageEmployeePage extends StatefulWidget {
  final bool isEditMode;
  final BigInt? employeeId;

  const ManageEmployeePage({
    super.key,
    required this.isEditMode,
    this.employeeId,
  });

  @override
  State<ManageEmployeePage> createState() => _ManageEmployeePageState();
}

class _ManageEmployeePageState extends State<ManageEmployeePage> {
  late final ManageEmployeeController controller;

  @override
  void initState() {
    super.initState();
    controller = ManageEmployeeController();

    if (widget.isEditMode && widget.employeeId != null) {
      controller.loadForEdit(widget.employeeId!);
    } else {
      controller.initForAdd();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // We handle pop manually
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldLeave = await _onBackPressed();
        if (shouldLeave && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEditMode
                ? 'Update Employee > ${widget.employeeId}'
                : 'Add Employee',
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ---------- Row 1: First Name, Middle Name, Last Name ----------
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'First Name',
                        required: true,
                        controller: controller.firstNameCtrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        label: 'Middle Name',
                        controller: controller.middleNameCtrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        label: 'Last Name',
                        required: true,
                        controller: controller.lastNameCtrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ---------- Row 2: Email and Phone ----------
                Row(
                  children: [
                    Expanded(
                      child: AppEmailField(
                        label: 'Email',
                        readOnly: widget.isEditMode,
                        required: true,
                        controller: controller.emailCtrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppPhoneField(controller: controller.phoneCtrl),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ---------- Row 3: Date of Birth and Gender ----------
                Row(
                  children: [
                    Expanded(
                      child: AppDateField(
                        label: 'Date of Birth',
                        required: true,
                        value: controller.dob,
                        onChanged: (date) =>
                            setState(() => controller.dob = date),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppRadioGroup<String>(
                        label: 'Gender',
                        required: true,
                        value: controller.gender,
                        options: [
                          AppRadioOption(value: 'M', label: 'Male'),
                          AppRadioOption(value: 'F', label: 'Female'),
                        ],
                        onChanged: (v) => setState(() => controller.gender = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ---------- Row 4: Department ----------
                AppDropdown<BigInt>(
                  label: 'Department',
                  required: true,
                  value: controller.departmentId != null
                      ? BigInt.from(controller.departmentId!)
                      : null,
                  items: [
                    AppDropdownOption(value: BigInt.from(1), label: 'Dept 1'),
                    AppDropdownOption(value: BigInt.from(2), label: 'Dept 2'),
                  ],
                  onChanged: (v) =>
                      setState(() => controller.departmentId = v?.toInt()),
                ),
                const SizedBox(height: 12),

                // ---------- Row 5: Address ----------
                AppTextField(
                  label: 'Address',
                  required: true,
                  controller: controller.addressCtrl,
                ),
                const SizedBox(height: 12),

                // ---------- Row 6: Country, State, Zipcode ----------
                Row(
                  children: [
                    Expanded(
                      child: AppDropdown<BigInt>(
                        label: 'Country',
                        required: true,
                        value: controller.countryId != null
                            ? BigInt.from(controller.countryId!)
                            : null,
                        items: [
                          AppDropdownOption(
                            value: BigInt.from(1),
                            label: 'India',
                          ),
                          AppDropdownOption(
                            value: BigInt.from(2),
                            label: 'USA',
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => controller.countryId = v?.toInt()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppDropdown<BigInt>(
                        label: 'State',
                        required: true,
                        value: controller.stateId != null
                            ? BigInt.from(controller.stateId!)
                            : null,
                        items: [
                          AppDropdownOption(
                            value: BigInt.from(1),
                            label: 'Gujarat',
                          ),
                          AppDropdownOption(
                            value: BigInt.from(2),
                            label: 'Goa',
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => controller.stateId = v?.toInt()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        label: 'Zipcode',
                        controller: controller.zipcodeCtrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ---------- Row 7: Languages, Hobbies, Working Days ----------
                Row(
                  children: [
                    Expanded(
                      child: AppMultiSelect<String>(
                        label: 'Languages',
                        required: true,
                        values: controller.languages,
                        options: [
                          AppMultiSelectOption(
                            value: 'English',
                            label: 'English',
                          ),
                          AppMultiSelectOption(value: 'Hindi', label: 'Hindi'),
                          AppMultiSelectOption(
                            value: 'Gujarati',
                            label: 'Gujarati',
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => controller.languages = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppCheckboxGroup<String>(
                        label: 'Hobbies',
                        values: controller.hobbies,
                        options: [
                          AppCheckboxOption(value: 'Reading', label: 'Reading'),
                          AppCheckboxOption(value: 'Cricket', label: 'Cricket'),
                          AppCheckboxOption(value: 'Music', label: 'Music'),
                        ],
                        onChanged: (v) =>
                            setState(() => controller.hobbies = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppCheckboxGroup<String>(
                        label: 'Working Days',
                        direction: Axis.horizontal,
                        values: controller.days,
                        options: const [
                          AppCheckboxOption(value: 'Mon', label: 'Mon'),
                          AppCheckboxOption(value: 'Tue', label: 'Tue'),
                          AppCheckboxOption(value: 'Wed', label: 'Wed'),
                        ],
                        onChanged: (v) => setState(() => controller.days = v),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                _actionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            //final canLeave = await _onBackPressed();
            //if (canLeave && context.mounted) {
            MainContentController.open(const EmployeePage());
            //}
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _submit,
          child: Text(widget.isEditMode ? 'Update' : 'Save'),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() async {
    if (!controller.isDirty) return true;

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Unsaved changes'),
        content: const Text(
          'You have unsaved changes. Do you really want to leave?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Stay'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  // ---------------- Submit ----------------

  void _submit() {
    if (!controller.formKey.currentState!.validate()) return;

    if (controller.gender == null) {
      setState(() {});
      return;
    }

    final ManageEmployeeModel model = controller.buildModel(
      employeeId: widget.employeeId,
    );

    final modelforAPI = controller.buildModel(employeeId: widget.employeeId);

    // 🔥 FULL CONSOLE LOG
    debugPrint('================ EMPLOYEE FORM DATA ================');
    debugPrint(modelforAPI.toJson().toString());
    debugPrint(model.toString());
    debugPrint('====================================================');

    if (widget.isEditMode) {
      // UPDATE API
      debugPrint('Updating Employee: ${model.employeeId}');
      controller.markSaved();
      // http.post(
      //   Uri.parse(url),
      //   body: jsonEncode(model.toJson()),
      //   headers: {'Content-Type': 'application/json'},
      // );
    } else {
      // ADD API
      debugPrint('Adding Employee');
      controller.markSaved();
      // http.post(
      //   Uri.parse(url),
      //   body: jsonEncode(model.toJson()),
      //   headers: {'Content-Type': 'application/json'},
      // );
    }

    AppSnackBar.show(
      context,
      message: 'Employee information updated successfully',
      type: SnackBarType.success,
    );
    MainContentController.open(EmployeePage());
  }
}
