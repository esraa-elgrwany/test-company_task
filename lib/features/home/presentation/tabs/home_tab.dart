import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/features/home/presentation/widgets/home_info_row.dart';

class HomeTab extends StatelessWidget{
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Row(
      children: [
      Image.asset("assets/images/people_8532963.png",width:36,height: 36,),
      SizedBox(width: 16.w,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              "welcome",
              style: Theme.of(context).textTheme.bodyMedium
            ),
            Text("user",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,fontSize: 16.sp
                )),
          ],
        ),
      ),]),
          SizedBox(height: 16.h,),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.network(UserManager().user?.empImg ?? "", fit: BoxFit.cover,
                    width: 160.w,
                    height: 160.h,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.person, size: 60.sp),),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(UserManager().user?.employee??"",
                            style: Theme.of(context).textTheme.bodyMedium
                        ),
                         SizedBox(height: 8.h),
                        Text(UserManager().user?.mosmaWazefyName??"",
                            style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(height: 8.h),
                        Text("employee code: ${UserManager().user?.empCode}",
                          style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  HomeInfoRow(title:"administration", value:UserManager().user?.edaraName??""),
                  const Divider(),
                 HomeInfoRow(title:"department", value:UserManager().user?.qsmName??""),
                  const Divider(),
                 HomeInfoRow(title:"phone number", value:UserManager().user?.phoneNumber??""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

