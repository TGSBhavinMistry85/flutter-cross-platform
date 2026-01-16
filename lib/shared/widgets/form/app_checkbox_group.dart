import 'package:flutter/material.dart';

class AppCheckboxOption<T> {
  final T value;
  final String label;

  const AppCheckboxOption({
    required this.value,
    required this.label,
  });
}

class AppCheckboxGroup<T> extends FormField<List<T>> {
  AppCheckboxGroup({
    super.key,
    required String label,
    required List<AppCheckboxOption<T>> options,
    required List<T> values,
    required ValueChanged<List<T>> onChanged,
    bool required = false,
    Axis direction = Axis.vertical,
    FormFieldValidator<List<T>>? validator,
    bool enabled = true,
  }) : super(
          initialValue: values,
          validator: validator ??
              (v) {
                if (required && (v == null || v.isEmpty)) {
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

                direction == Axis.vertical
                    ? Column(
                        children: _buildOptions(
                          state,
                          options,
                          onChanged,
                          enabled,
                        ),
                      )
                    : Wrap(
                        spacing: 16,
                        runSpacing: 4,
                        children: _buildOptions(
                          state,
                          options,
                          onChanged,
                          enabled,
                        ),
                      ),

                // Error
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 4),
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

  static List<Widget> _buildOptions<T>(
    FormFieldState<List<T>> state,
    List<AppCheckboxOption<T>> options,
    ValueChanged<List<T>> onChanged,
    bool enabled,
  ) {
    return options.map((opt) {
      final selected = state.value?.contains(opt.value) ?? false;

      return CheckboxListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        value: selected,
        title: Text(opt.label),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: enabled
            ? (v) {
                final newValues = List<T>.from(state.value ?? []);

                if (v == true) {
                  newValues.add(opt.value);
                } else {
                  newValues.remove(opt.value);
                }

                state.didChange(newValues);
                onChanged(newValues);
              }
            : null,
      );
    }).toList();
  }
}