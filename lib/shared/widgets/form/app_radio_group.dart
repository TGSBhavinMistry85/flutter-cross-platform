import 'package:flutter/material.dart';

class AppRadioOption<T> {
  final T value;
  final String label;

  AppRadioOption({
    required this.value,
    required this.label,
  });
}

class AppRadioGroup<T> extends StatelessWidget {
  final String label;
  final bool required;
  final T? value;
  final List<AppRadioOption<T>> options;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const AppRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.value,
    this.required = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: value,
      validator: validator ??
          (v) {
            if (required && v == null) {
              return '$label is required';
            }
            return null;
          },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                required ? '$label *' : label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Radio options
            Wrap(
              spacing: 16,
              children: options.map((opt) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<T?>(
                      value: opt.value,
                      groupValue: state.value,
                      onChanged: (T? v) {
                        if (v == null) return;
                        state.didChange(v);
                        onChanged(v);
                      },
                    ),
                    Text(opt.label),
                  ],
                );
              }).toList(),
            ),

            // Error
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}