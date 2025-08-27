import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/config/routes/routes.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/pages/add_holiday_screen.dart';
import 'package:task/features/home/presentation/widgets/holiday_card.dart';
import 'package:task/features/home/presentation/widgets/holiday_filter_bar.dart';

class HolidayTab extends StatefulWidget {
  const HolidayTab({super.key});

  @override
  State<HolidayTab> createState() => _HolidayTabState();
}

class _HolidayTabState extends State<HolidayTab> {
  @override
  void initState() {
    context.read<HomeCubit>().getAgazaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              HolidayFilterBar(
              ),
              SizedBox(height: 16.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is AgazaListLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  } else if (state is AgazaListFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                            size: 50,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            state.failure.errorMsg,
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  } else if (state is AgazaListSuccess) {
                    final agazaList = context.read<HomeCubit>().agazaList;
                    if (agazaList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month_rounded, color: Colors.grey, size: 50.sp),
                            SizedBox(height: 12),
                            Text(
                              "No Holidays Found",
                              style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: agazaList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.holidayDetails,
                                arguments: agazaList[index],
                              );
                            },
                            child: HolidayCard(index: index),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () async{
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddHolidayScreen()),
                );

                if (result == true) {
                  context.read<HomeCubit>().getAgazaList();
                }
              },
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColors.primaryColor.withOpacity(.9),
                child: Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
        )
      ],
    );
  }
}
