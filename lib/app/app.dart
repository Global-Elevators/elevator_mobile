import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/resources/routes_manager.dart';
import 'package:elevator/presentation/resources/theme_manager.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  didChangeDependencies() {
    _appPreferences.getLocalLanguage().then((locale) {
      context.setLocale(locale);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(AppSize.s402, AppSize.s874),
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouterConfig.router,
        theme: getApplicationTheme(),
      ),
    );
  }
}