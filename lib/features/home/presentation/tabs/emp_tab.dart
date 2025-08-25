import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/widgets/holiday_card.dart';

class EmpTab extends StatefulWidget{
  const EmpTab({super.key});

  @override
  State<EmpTab> createState() => _EmpTabState();
}

class _EmpTabState extends State<EmpTab> {
  @override
  void initState() {
    context.read<HomeCubit>().getAgazaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
                      SizedBox(height: 12),
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
                        Icon(Icons.calendar_month_rounded, color: Colors.grey, size: 50),
                        SizedBox(height: 12),
                        Text(
                          "No Holidays Found",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
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
                          /*Navigator.pushNamed(
                            context,
                            CourseDetailsScreen.routeName,
                            arguments: courses[index],
                          );*/
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
    );
  }
}

