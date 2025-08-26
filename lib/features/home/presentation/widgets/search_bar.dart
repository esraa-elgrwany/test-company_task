import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onClear;
  final ValueChanged<String>? onSearch;

  const SearchBarWidget({required this.controller,
    this.onClear,
    this.onSearch,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w500
              ),
              onFieldSubmitted: onSearch,
              decoration: InputDecoration(
                hintText: "search...",
                hintStyle: TextStyle(color: Color(0XFF545454),
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: Color(0XFFECECEC),
                prefixIcon: Icon(Icons.search, color:AppColors.primaryColor,size: 24.sp,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0XFFECECEC),)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0XFFECECEC))),
                suffixIcon: InkWell(
                    onTap: onClear,
                    child: Icon(Icons.clear, color:AppColors.primaryColor,size: 24.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
