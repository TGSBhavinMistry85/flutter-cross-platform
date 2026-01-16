import 'package:flutter/material.dart';
import 'app_text_field.dart';

class AppEmailField extends StatelessWidget {
  final String label;
  final bool required;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const AppEmailField({
    super.key,
    this.label = 'Email',
    this.required = true,
    required this.controller,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      required: required,
      controller: controller,
      readOnly: readOnly,
      keyboardType: TextInputType.emailAddress,
      validator: validator ?? _defaultValidator,
    );
  }

  String? _defaultValidator(String? value) {
    if (required && (value == null || value.trim().isEmpty)) {
      return '$label is required';
    }

    if (value != null && value.isNotEmpty) {
      final emailRegex =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }

    return null;
  }
}