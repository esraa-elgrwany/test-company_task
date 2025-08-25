import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/helper/user_manager/user_manager.dart';
import 'package:task/my_app.dart';
import 'core/cache/shared_preferences.dart';
import 'core/utils/observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await CacheData.init();
  String start;
  String? empId=UserManager().user?.empId;
  if(empId==null){
    start="/";
  }else{
    start="home";
  }
  runApp(MyApp(start));
}
