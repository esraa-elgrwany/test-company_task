import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/widgets/employee_card.dart';
import 'package:task/features/home/presentation/widgets/search_bar.dart';

class EmpTab extends StatefulWidget{
  const EmpTab({super.key});

  @override
  State<EmpTab> createState() => _EmpTabState();
}

class _EmpTabState extends State<EmpTab> {
  @override
  void initState() {
    context.read<HomeCubit>().getEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchBarWidget(
            controller:HomeCubit.get(context).searchController,
            onSearch: (query) {
              if (HomeCubit.get(context).searchController.text.isNotEmpty) {
                context.read<HomeCubit>().getEmployee(
                  search: HomeCubit.get(context).searchController.text
                );
              }else {
                context.read<HomeCubit>().getEmployee();
              }
            },
            onClear: () {
              setState(() {
                HomeCubit.get(context).searchController.clear();
                context.read<HomeCubit>().getEmployee();
              });
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetEmployeeLoading) {
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
              } else if (state is GetEmployeeSuccess) {
                final employeeList = context.read<HomeCubit>().employeeList;
                if (employeeList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_rounded, color: Colors.grey, size: 50),
                        SizedBox(height: 12),
                        Text(
                          "No Employee Found",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: employeeList.length,
                    itemBuilder: (context, index) {
                      return EmployeeCard(index: index);
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

