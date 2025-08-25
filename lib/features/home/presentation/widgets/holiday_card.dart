import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';

class HolidayCard extends StatelessWidget {
  int index;

  HolidayCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final agaza = HomeCubit.get(context).agazaList;

    if (agaza.isEmpty || index >= agaza.length) {
      return Center(
        child: Text(
          "No Agaza Available",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      elevation: 4,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,size: 22.sp,color: AppColors.primaryColor,),
                    SizedBox(width: 8.w,),
                    Text("${agaza[index].fromDate}",style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Text(
                  "رقم الطلب: ${agaza[index].requestNumber}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(agaza[index].status,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16.sp
                  ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10.r),
                    side: BorderSide(
                      color: _statusColor(agaza[index].status),
                    )
                  ),
                  backgroundColor: _statusColor(agaza[index].status),
                ),
                Text(
                  "نوع الاجازة: ${agaza[index].holidayTypeName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "wared":
        return Colors.blue.shade100;
      case"جارى":
        return Colors.green.shade100;
      case "accepted":
        return Colors.green.shade400;
      case "refused":
        return Colors.red.shade200;
      default:
        return Colors.grey.shade200;
    }
  }
}
