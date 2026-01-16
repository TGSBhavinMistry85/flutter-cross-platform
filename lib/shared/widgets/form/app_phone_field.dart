import 'package:flutter/material.dart';
import 'app_text_field.dart';

class AppPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const AppPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'Phone',
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: (v) =>
          v == null || v.length < 10
              ? 'Enter valid phone number'
              : null,
    );
  }
}