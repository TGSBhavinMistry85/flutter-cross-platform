import 'package:flutter/material.dart';
import 'app_text_field.dart';

class AppTextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const AppTextArea({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      controller: controller,
      maxLines: 4,
    );
  }
}
