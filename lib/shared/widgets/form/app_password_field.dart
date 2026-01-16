import 'package:flutter/material.dart';
import 'app_text_field.dart';

class AppPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const AppPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Password',
      controller: controller,
      obscureText: true,
      validator: (v) =>
          v == null || v.length < 6
              ? 'Minimum 6 characters'
              : null,
    );
  }
}