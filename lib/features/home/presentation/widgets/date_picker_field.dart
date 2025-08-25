import 'package:flutter/material.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/code/presentation/widgets/text_form_widget.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(DateTime)? onDateSelected;

  const DatePickerField({
    Key? key,
    required this.label,
    required this.controller,
    this.onDateSelected,
  }) : super(key: key);

  Future<void> _pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split("T").first;
      onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormWidget(controller: controller, hint: label, icon: Icons.calendar_month, validateTxt: "please select date")
      ),
    );
  }
}
