import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/pages/signature_screen.dart';
import 'package:task/features/home/presentation/widgets/profile_detail_tile.dart';

import '../../../../config/routes/routes.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.network(
            UserManager().user?.empImg ?? "",
            fit: BoxFit.cover,
            width: 240.w,
            height: 160.h,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.person, size: 60.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            UserManager().user?.employee ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            UserManager().user?.mosmaWazefyName ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          SizedBox(height: 24.h),
          ProfileDetailTile(
            title: "كود الموظف",
            value: UserManager().user?.empCode ?? "",
          ),
          ProfileDetailTile(
            title: "الإدارة",
            value: UserManager().user?.edaraName ?? "",
          ),
          ProfileDetailTile(
            title: "القسم",
            value: UserManager().user?.qsmName ?? "",
          ),
          ProfileDetailTile(
            title: "رقم الهاتف",
            value: UserManager().user?.phoneNumber ?? "",
          ),
          ProfileDetailTile(
            title: "رقم الكارت",
            value: UserManager().user?.cardNum ?? "",
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text("التوقيع", style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(width: 8.w),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final cubit = HomeCubit.get(context);
                    if (state is SignatureUpdated) {
                      return Image.file(state.signatureFile);
                    }
                    return cubit.signatureFile != null
                        ? Image.network(
                            cubit.uploadedSignature ?? "",
                            fit: BoxFit.contain,
                            width: 80.w,
                            height: 80.h,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error, size: 40.sp),
                          )
                        : Image.network(
                            UserManager().user?.empSignature ?? "",
                            fit: BoxFit.contain,
                            width: 80.w,
                            height: 80.h,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error, size: 40.sp),
                          );
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignatureScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // optional
                  ),
                  child: Text(
                    "Add Signature",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.white),

                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log out",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    CompanyManager().clearCompany();
                    UserManager().clearUser();
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesName.codeScreen,
                    );
                  },
                  child: Image.asset(
                    "assets/images/logout_4263209.png",
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
