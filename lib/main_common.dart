import 'package:elevator/app/flavor_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:elevator/domain/notification/app_notification_manager.dart';

void mainCommon({
  required Flavor flavor,
  required bool isPaid,
  required String name,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await EasyLocalization.ensureInitialized();

  await initAppModule();

  FlavorConfig(flavor: flavor, isPaid: isPaid, name: name);

  runApp(
    EasyLocalization(
      supportedLocales: [englishLocale, arabicLocale],
      path: assetPathLocalization,
      fallbackLocale: englishLocale,
      child: Phoenix(child: MyApp()),
    ),
  );
}
