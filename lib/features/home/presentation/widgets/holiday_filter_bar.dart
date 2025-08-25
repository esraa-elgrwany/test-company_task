import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';

class HolidayFilterBar extends StatelessWidget {
  const HolidayFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        final selectedStatus = cubit.selectedStatus;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: cubit.statusList.map((type) {
              bool isSelected = selectedStatus == type;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    cubit.changeStatus(type);
                    cubit.getAgazaList();
                  },
                  child: Container(
                    width: 120.w,
                    height: 50.h,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(.9)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: isSelected
                          ? [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


