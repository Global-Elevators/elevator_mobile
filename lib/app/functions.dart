import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

bool isTextNotEmpty(String text) => text.isNotEmpty;

bool isPasswordValid(String password) => password.isNotEmpty;

bool isPhoneValid(String phone) => phone.isNotEmpty;

bool isNumberNotZero(int number) => number != 0;

void changeLanguage(BuildContext context) async {
  final appPreferences = instance<AppPreferences>();
  await appPreferences.changeAppLanguage();
  context.go(SplashView.splashRoute);
  await Phoenix.rebirth(context);
}

Future<void> openUrl(String link) async {
  final Uri url = Uri.parse(link);
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

// bool isPhoneValid(String phone) {
//   // Iraqi phone: starts with 07 + 9 digits (total 11 digits)
//   final phoneRegex = RegExp(r'^07[0-9]{9}$');
//   return phoneRegex.hasMatch(phone.trim());
// }

// bool isPasswordValid(String password) {
//   // Strong password: min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special char
//   final passwordRegex =
//   RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   return passwordRegex.hasMatch(password);
// }

// bool userNameValid(String userName) {
//   // At least 3 characters, letters, numbers, underscores
//   final nameRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
//   return nameRegex.hasMatch(userName.trim());
// }

// bool isNotEmpty(String value) {
//   return value.trim().isNotEmpty;
// }
