import 'package:flutter/material.dart';

class DropDownContainer<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;

  const DropDownContainer({
    Key? key,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: items
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(itemLabel(e)),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
