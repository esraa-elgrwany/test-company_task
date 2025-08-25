import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_strings.dart';

class PasswordTextForm extends StatefulWidget{
  final TextEditingController controller;

   PasswordTextForm({
    Key? key,
    required this.controller,
  });

  @override
  State<PasswordTextForm> createState() => _PasswordTextFormState();
}

class _PasswordTextFormState extends State<PasswordTextForm> {
  bool secure = true;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(color: Colors.grey),
    );
    return TextFormField(
      style: TextStyle(color:Colors.black,fontSize: 14.sp,fontWeight:FontWeight.w500),
      controller: widget.controller,
      obscureText: secure ? true : false,
      decoration: InputDecoration(
        hintText: AppStrings.password,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.grey,
        ),
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        suffixIcon: IconButton(
          onPressed: () {
            secure = !secure;
            setState(() {});
          },
          icon: secure
              ? Icon(Icons.visibility_off, size: 22.sp)
              : Icon(
            Icons.visibility,
            size: 22,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.passwordValid;
        }
        return null;
      },
    );
  }
}
