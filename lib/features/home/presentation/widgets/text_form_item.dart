import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormItem extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;

  const TextFormItem({
    Key? key,
    required this.label,
    required this.controller,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: Colors.grey),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        TextFormField(
        style: TextStyle(color:Colors.black,fontSize: 14.sp,fontWeight:FontWeight.w500),
        controller: controller,
        decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Colors.grey,
        ),
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        suffixIcon: Icon(Icons.edit, size: 22.sp),
        ),
    )
      ],
    );
  }
}
