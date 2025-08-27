import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task/config/theming/my_theme.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(MyThemeData.lightTheme(CompanyManager().primaryColor));

  void updatePrimaryColor(Color color) {
    emit(MyThemeData.lightTheme(color));
  }
}


