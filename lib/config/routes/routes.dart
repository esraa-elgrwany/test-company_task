import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task/features/code/presentation/pages/code_screen.dart';
import 'package:task/features/home/domain/entities/get_holiday_entity.dart';
import 'package:task/features/home/presentation/pages/add_holiday_screen.dart';
import 'package:task/features/home/presentation/pages/edit_holiday_screen.dart';
import 'package:task/features/home/presentation/pages/holiday_details_screen.dart';
import 'package:task/features/home/presentation/pages/home_screen.dart';
import 'package:task/features/home/presentation/pages/signature_screen.dart';
import 'package:task/features/login/presentation/pages/login_screen.dart';


class RoutesName {
  static const String codeScreen = "/";
  static const String login = "login";
  static const String home = "home";
  static const String signature = "signature";
  static const String holidayDetails = "holidayDetails";
  static const String addHoliday = "addHoliday";
  static const String editHoliday = "editHoliday";
}

class AppRouter {
  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.codeScreen:
        return MaterialPageRoute(
          builder: (context) => CodeScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RoutesName.signature:
    return MaterialPageRoute(
          builder: (context) => SignatureScreen(),
        );
      case RoutesName.holidayDetails:
        HolidayEntityData data =
        settings.arguments as HolidayEntityData;
        return MaterialPageRoute(
          builder: (context) => HolidayDetailsScreen(args: data),
        );
      case RoutesName.addHoliday:
        return MaterialPageRoute(
          builder: (context) => AddHolidayScreen(),
        );
      case RoutesName.editHoliday:
        HolidayEntityData data =
        settings.arguments as HolidayEntityData;
        return MaterialPageRoute(
          builder: (context) => EditHolidayScreen(args: data,),
        );
        default:
          return MaterialPageRoute(
            builder: (context) => UnDefineScreen(),
          );
    }
  }
  static Widget UnDefineScreen(){
    return Scaffold(
      appBar: AppBar(
          title: Text("Undefine page"),
      ),
      body: Center(
        child: Text("Page not found"),
      ),
    );
  }
}
