import 'package:flutter/material.dart';
import '../logic/mangeEmployee_controller.dart';
import '../model/employee_model.dart';

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
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _textField('First Name', controller.firstNameCtrl),
              _textField('Middle Name', controller.middleNameCtrl,
                  required: false),
              _textField('Last Name', controller.lastNameCtrl),
              _emailField(),
              if (!widget.isEditMode) _passwordField(),
              _textField('Phone', controller.phoneCtrl,
                  type: TextInputType.phone),
              _datePicker(),
              _genderRadio(),
              _dropdown(
                'Department',
                controller.departmentId,
                (v) => setState(() => controller.departmentId = v),
              ),
              _textField('Address', controller.addressCtrl),
              _dropdown(
                'Country',
                controller.countryId,
                (v) => setState(() => controller.countryId = v),
              ),
              _dropdown(
                'State',
                controller.stateId,
                (v) => setState(() => controller.stateId = v),
              ),
              _textField('Zipcode', controller.zipcodeCtrl,
                  type: TextInputType.number),
              const SizedBox(height: 20),
              _actionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _textField(String label, TextEditingController ctrl,
      {bool required = true, TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        validator: (v) =>
            required && (v == null || v.isEmpty) ? '$label is required' : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller.emailCtrl,
        validator: (v) {
          if (v == null || v.isEmpty) return 'Email is required';
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
            return 'Enter valid email';
          }
          return null;
        },
        decoration: const InputDecoration(labelText: 'Email'),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        //controller: controller.passwordCtrl,
        obscureText: true,
        validator: (v) =>
            v == null || v.length < 6 ? 'Minimum 6 characters' : null,
        decoration: const InputDecoration(labelText: 'Password'),
      ),
    );
  }

  Widget _genderRadio() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender'),
          Row(
            children: [
              Radio<String>(
                value: 'M',
                groupValue: controller.gender,
                onChanged: (v) =>
                    setState(() => controller.gender = v),
              ),
              const Text('Male'),
              Radio<String>(
                value: 'F',
                groupValue: controller.gender,
                onChanged: (v) =>
                    setState(() => controller.gender = v),
              ),
              const Text('Female'),
            ],
          ),
          if (controller.gender == null)
            const Text(
              'Gender is required',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _datePicker() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        controller.dob == null
            ? 'Select Date of Birth'
            : controller.dob!.toString().split(' ')[0],
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialDate: controller.dob ?? DateTime.now(),
        );
        if (date != null) {
          setState(() => controller.dob = date);
        }
      },
    );
  }

  Widget _dropdown(String label, int? value, ValueChanged<int?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<int>(
        value: value,
        validator: (v) => v == null ? '$label is required' : null,
        decoration: InputDecoration(labelText: label),
        items: const [
          DropdownMenuItem(value: 1, child: Text('Option 1')),
          DropdownMenuItem(value: 2, child: Text('Option 2')),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
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

    if (widget.isEditMode) {
      // UPDATE API (later)
      debugPrint('Updating Employee: ${model.employeeId}');
    } else {
      // ADD API (later)
      debugPrint('Adding Employee');
    }

    Navigator.pop(context);
  }
}