import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/utils/app_colors.dart';

class Header extends StatelessWidget {

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Image.network(CompanyManager().logo,width: 240.w,height: 160.h,fit: BoxFit.contain,
        ),
        SizedBox(height: 16.h),
            Text(
              CompanyManager().name,
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
      ],
    );
  }
}
