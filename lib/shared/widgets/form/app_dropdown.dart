import 'package:flutter/material.dart';

class AppDropdownOption<T> {
  final T value;
  final String label;

  const AppDropdownOption({
    required this.value,
    required this.label,
  });
}

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final bool required;
  final T? value;
  final List<AppDropdownOption<T>> items;
  final ValueChanged<T?> onChanged;
  final String hint;
  final String? Function(T?)? validator;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.required = false,
    this.hint = 'Select',
    this.validator,
    this.enabled = true,
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

            // Dropdown
            InputDecorator(
              decoration: InputDecoration(
                isDense: true,
                enabled: enabled,
                errorText: state.errorText,
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: state.value,
                  hint: Text(hint),
                  isExpanded: true,
                  onChanged: enabled
                      ? (v) {
                          state.didChange(v);
                          onChanged(v);
                        }
                      : null,
                  items: items
                      .map(
                        (e) => DropdownMenuItem<T>(
                          value: e.value,
                          child: Text(e.label),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}