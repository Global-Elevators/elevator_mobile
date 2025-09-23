import 'dart:io';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/app/insecure_http_overrides.dart';
import 'app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  if (!kReleaseMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
  runApp(MyApp());
}
// 01012345678

// Storng1234FG@#32