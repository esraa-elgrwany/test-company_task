import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/features/home/presentation/manager/home_cubit.dart';
import 'package:task/features/home/presentation/tabs/emp_tab.dart';
import 'package:task/features/home/presentation/tabs/holiday_tab.dart';
import 'package:task/features/home/presentation/tabs/home_tab.dart';
import 'package:task/features/home/presentation/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<Widget> tabs = [HomeTab(), HolidayTab(),EmpTab() ,ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(CompanyManager().name),
          leading: SizedBox(),
        ),
        body: tabs[index],
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
                left: 8, right: 8, bottom: 8
            ),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              borderRadius: BorderRadius.all(Radius.circular(36.r)),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(36.r)),
                child: BottomNavigationBar(

                  backgroundColor: Colors.transparent, // ✅ important
                  elevation: 0,
                  onTap: (value) {
                    index = value;
                    setState(() {});
                  },
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.calendar_month_rounded,
                        ),
                        label: "Holidays"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                        ),
                        label: "Employees"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.list_alt_outlined,
                        ),
                        label: "Profile"),
                  ],
                ))),
      ),
    );
  }
}

