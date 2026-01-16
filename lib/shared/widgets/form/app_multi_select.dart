import 'package:flutter/material.dart';

class AppMultiSelectOption<T> {
  final T value;
  final String label;

  const AppMultiSelectOption({required this.value, required this.label});
}

class AppMultiSelect<T> extends FormField<List<T>> {
  AppMultiSelect({
    super.key,
    required String label,
    required List<AppMultiSelectOption<T>> options,
    required List<T> values,
    required ValueChanged<List<T>> onChanged,
    bool required = false,
    String hint = 'Select',
    FormFieldValidator<List<T>>? validator,
    bool enabled = true,
  }) : super(
         initialValue: values,
         validator:
             validator ??
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

               // Container
               InkWell(
                 onTap: enabled
                     ? () async {
                         final result = await showDialog<List<T>>(
                           context: state.context,
                           builder: (_) => _MultiSelectDialog<T>(
                             title: label,
                             options: options,
                             selected: List.from(state.value ?? []),
                           ),
                         );

                         if (result != null) {
                           state.didChange(result);
                           onChanged(result);
                         }
                       }
                     : null,
                 child: InputDecorator(
                   decoration: InputDecoration(
                     isDense: true,
                     enabled: enabled,
                     errorText: state.errorText,
                     border: const OutlineInputBorder(),
                     contentPadding: const EdgeInsets.all(12),
                   ),
                   child: Wrap(
                     spacing: 8,
                     runSpacing: 4,
                     children: state.value == null || state.value!.isEmpty
                         ? [
                             Text(
                               hint,
                               style: TextStyle(color: Colors.grey.shade600),
                             ),
                           ]
                         : state.value!
                               .map(
                                 (e) => Chip(
                                   label: Text(
                                     options
                                         .firstWhere((o) => o.value == e)
                                         .label,
                                   ),
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

class _MultiSelectDialog<T> extends StatefulWidget {
  final String title;
  final List<AppMultiSelectOption<T>> options;
  final List<T> selected;

  const _MultiSelectDialog({
    required this.title,
    required this.options,
    required this.selected,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _tempSelected;

  @override
  void initState() {
    super.initState();
    _tempSelected = List.from(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          children: widget.options.map((e) {
            final selected = _tempSelected.contains(e.value);

            return CheckboxListTile(
              value: selected,
              title: Text(e.label),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    _tempSelected.add(e.value);
                  } else {
                    _tempSelected.remove(e.value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _tempSelected),
          child: const Text('Done'),
        ),
      ],
    );
  }
}