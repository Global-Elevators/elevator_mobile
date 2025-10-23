import 'package:elevator/app/flavor_config.dart';
import 'package:elevator/main_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';

void mainCommon({
  required Flavor flavor,
  required bool isPaid,
  required String name,
}) async {
  FlavorConfig(flavor: flavor, isPaid: isPaid, name: name);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: [englishLocale, arabicLocale],
      path: assetPathLocalization,
      fallbackLocale: englishLocale,
      child: Phoenix(child: MyApp()),
    ),
  );
}
