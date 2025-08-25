import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String validateTxt;

  const TextFormWidget({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.validateTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
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
        suffixIcon: Icon(icon, size: 22.sp),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateTxt;
        }
        return null;
      },
    );
  }
}

