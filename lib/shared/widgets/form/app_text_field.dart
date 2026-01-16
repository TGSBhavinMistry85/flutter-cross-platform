import 'package:flutter/material.dart';
import '../app_form_theme.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final TextInputType keyboardType;
  final bool readOnly;
  final int maxLines;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
        obscureText: obscureText,
        validator: validator ??
            (v) =>
                required && (v == null || v.trim().isEmpty)
                    ? '$label is required'
                    : null,
        decoration: AppFormTheme.decoration(label: label),
      ),
    );
  }
}