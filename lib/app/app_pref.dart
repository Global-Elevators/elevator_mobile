import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../presentation/resources/language_manager.dart';

const String pressKeyLanguage = "PRESS_KEY_LANGUAGE";

class AppPreferences {
  final FlutterSecureStorage _secureStorage;

  AppPreferences()
    : _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  Future<String> getAppLanguage() async {
    final language = await _secureStorage.read(key: pressKeyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    }
    return LanguageType.english.getValue();
  }

  Future<void> changeAppLanguage() async {
    final currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      await _secureStorage.write(
        key: pressKeyLanguage,
        value: LanguageType.english.getValue(),
      );
    } else {
      await _secureStorage.write(
        key: pressKeyLanguage,
        value: LanguageType.arabic.getValue(),
      );
    }
  }


  Future<Locale> getLocalLanguage() async {
    final currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<void> setUserToken(String key, String token) async {
    await _secureStorage.write(key: key, value: token);
  }

  Future<String> getUserToken(String key) async {
    return await _secureStorage.read(key: key) ?? "";
  }

  Future<bool> isUserLoggedIn(String key) async {
    final token = await _secureStorage.read(key: key);
    return token != null && token.isNotEmpty;
  }

  Future<void> logOut(String key) async {
    await _secureStorage.delete(key: key);
  }
}
