import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/constants.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/presentation/widgets/holiday_details_row.dart';


class HolidayDetailsScreen extends StatelessWidget {
  HolidayEntityData args;
  HolidayDetailsScreen({super.key,required this.args});

  @override
  Widget build(BuildContext context) {
    String baseUrl = "https://mydomain.com/";
    //late  HolidayEntityData args = ModalRoute.of(context)!.settings.arguments as HolidayEntityData;
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل الأجازة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                 "${Constants.baseUrl}${args.attachment}",
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150.h,
                    width: 320.w,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: 80.sp),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              HolidayDetailsRow(title: "اسم الموظف:",value: args.employeeName),
              HolidayDetailsRow(title: "نوع الأجازة:",value:args.holidayTypeName),
              HolidayDetailsRow(title: "تاريخ الطلب:", value: args.requestDate,),
              HolidayDetailsRow(title: "من:", value: args.fromDate,),
              HolidayDetailsRow(title: "إلى:",value: args.toDate,),
              HolidayDetailsRow(title: "عدد الأيام:",value: args.toDate,),
              HolidayDetailsRow(title: "الحالة:",value: args.status,),
              HolidayDetailsRow(title: "السبب:", value: args.reason,),
              HolidayDetailsRow(title: "رقم الأجازة:", value: args.requestNumber,),
              HolidayDetailsRow(title: "إمكانية تعديل/حذف:",value: args.canEditOrDelete,),
            ],
          ),
        ),
      ),
    );
  }
}

