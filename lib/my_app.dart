import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/config/routes/routes.dart' show AppRouter;
import 'package:task/config/theming/my_theme.dart';


class MyApp extends StatelessWidget {
  String start;

  MyApp(this.start);
  @override
  Widget build(BuildContext context) {
          return ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: start,
              onGenerateRoute: (settings) => AppRouter.onGenerate(settings),
              theme: MyThemeData.lightTheme,
            ),
          );
  }
}
