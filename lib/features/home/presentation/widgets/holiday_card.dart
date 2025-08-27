import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';

import '../../../../config/routes/routes.dart';

class HolidayCard extends StatelessWidget {
  final int index;

  const HolidayCard({
    super.key,
    required this.index,
  });

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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// --- التاريخ ورقم الطلب ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 22.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "${agaza[index].fromDate}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Text(
                  "رقم الطلب: ${agaza[index].requestNumber}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 8.h),

            /// --- الحالة ونوع الاجازة ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    agaza[index].status,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16.sp),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(
                      color: _statusColor(agaza[index].status),
                    ),
                  ),
                  backgroundColor: _statusColor(agaza[index].status),
                ),
                Text(
                  "نوع الاجازة: ${agaza[index].holidayTypeName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            SizedBox(height: 12.h),
            Row(
              children: [
                BlocListener<HomeCubit, HomeState>(
  listener: (context, state) {
    if (state is DeleteAgazaFailure) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Text(
            "Error",
          ),
          content: Text(
            state.failure.errorMsg,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("okay",
                    style: TextStyle(
                        color: Colors.white))),
          ],
        ),
      );
    } else if (state is DeleteAgazaSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
              child: Text(
                "Agaza deleted successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 14),
              ),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: 4)),
      );
    }
  },
  child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) =>
                          AlertDialog(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .onBackground,
                            title: Text("Delete"),
                            content: Text(
                                "Are you sure you want to delete this task"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(dialogContext),
                                child: Text("cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .deleteAgaza(
                                      id: agaza[index].id);
                                  Navigator.pop(dialogContext);
                                },
                                child: Text("delete",
                                    style: TextStyle(
                                        color: Colors.red)),
                              ),
                            ],
                          ),);
                  },
                    child: Icon(Icons.delete,color: Colors.red,size: 24.sp)),
),
                Spacer(),
                InkWell(
                  onTap: () async{
                    final result = await Navigator.pushNamed(
                      context,
                      RoutesName.editHoliday,
                      arguments: agaza[index]
                    );
                    if (result == true) {
                      context.read<HomeCubit>().getAgazaList();
                    }
                  },
                    child: Icon(Icons.edit,color: Colors.blue,size: 24.sp)),
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
      case "جارى":
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

