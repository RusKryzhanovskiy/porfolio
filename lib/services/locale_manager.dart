import 'package:flutter/material.dart';
import 'hive_service.dart';

class LocaleManager extends ChangeNotifier {
  static const Locale ukrainian = Locale('uk');
  static const Locale english = Locale('en');

  static const List<Locale> supportedLocales = <Locale>[ukrainian, english];

  Locale _locale = english;

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final value = await HiveService().get('settings', 'locale');
    if (value != null) {
      _locale = Locale(value);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    await HiveService().put('settings', 'locale', locale.languageCode);
    notifyListeners();
  }
}
