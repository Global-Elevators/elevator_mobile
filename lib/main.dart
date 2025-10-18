import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  // if (!kReleaseMode) {
  //   HttpOverrides.global = MyHttpOverrides();
  // }
  runApp(
    EasyLocalization(
      supportedLocales: [englishLocale, arabicLocale],
      path: assetPathLocalization,
      fallbackLocale: englishLocale,
      child: Phoenix(child: MyApp()),
    ),
  );
}

// line length in dart 80