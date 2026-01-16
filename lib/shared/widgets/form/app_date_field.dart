import 'package:flutter/material.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final bool required;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime firstDate;
  final DateTime lastDate;

  AppDateField({
    super.key,
    required this.label,
    required this.onChanged,
    this.value,
    this.required = false,
    DateTime? minDate,
    DateTime? maxDate,
  })  : firstDate = minDate ?? DateTime(1900),
        lastDate = maxDate ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          value == null
              ? ''
              : '${value!.year}-${value!.month.toString().padLeft(2, '0')}-${value!.day.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }
}