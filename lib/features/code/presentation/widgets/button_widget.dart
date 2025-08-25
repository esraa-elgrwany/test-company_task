import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget{
  String txt;

   ButtonWidget({required this.txt});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:MediaQuery.of(context).size.width-160.w,
      height: 60.h,
        decoration: BoxDecoration(
          color:Colors.blue,borderRadius: BorderRadius.circular(16.r)
        ),
        child: Center(
          child: Text(
              txt,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white
              )
          ),
        ),
    );
  }
}
