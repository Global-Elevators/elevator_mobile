import 'package:elevator/presentation/resources/routes_manager.dart';
import 'package:elevator/presentation/resources/theme_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(AppSize.s402, AppSize.s874),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouterConfig.router,
        theme: getApplicationTheme(),
      ),
    );
  }
}
