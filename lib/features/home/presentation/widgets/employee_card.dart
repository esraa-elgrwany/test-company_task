import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
class EmployeeCard extends StatelessWidget {
 final int index;

  const EmployeeCard({
    super.key,
   required this.index
  });

  @override
  Widget build(BuildContext context) {
    final employee = HomeCubit.get(context).employeeList;

    if (employee.isEmpty || index >= employee.length) {
      return Center(
        child: Text(
          "No Employee Available",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
    return Card(
      elevation: 4,
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical:12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Image.network(employee[index].empImg ?? "", fit: BoxFit.contain,
                width: 80.w,
                height: 80.h,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 40.sp,),),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee[index].employee ?? "غير معروف",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "الإدارة: ${employee[index].edaraName ?? "-"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "القسم: ${employee[index].qsmName ?? "-"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.badge, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text("كود: ${employee[index].empCode ?? "-"}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(employee[index].phoneNumber ?? "-"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
