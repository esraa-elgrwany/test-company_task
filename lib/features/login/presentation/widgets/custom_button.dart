import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget{
  String txt;

   CustomButton({super.key,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width-160.w,
      height: 60.h,
      decoration: BoxDecoration(
          color:AppColors.primaryColor,borderRadius: BorderRadius.circular(16.r)
      ),
      child: Center(
        child: Text(
            txt,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white
            )
        ),
      ),
    );;
  }
}
