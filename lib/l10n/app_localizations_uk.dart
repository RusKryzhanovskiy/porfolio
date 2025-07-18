// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Трекер портфеля';

  @override
  String get porfolioTab => 'Портфель';

  @override
  String get marketsTab => 'Ринки';

  @override
  String get analyticsTab => 'Аналітика';

  @override
  String get profileTab => 'Профіль';

  @override
  String get settings => 'Налаштування';

  @override
  String get language => 'Мова';

  @override
  String get currency => 'Валюта';

  @override
  String get changeLanguage => 'Змінити мову:';

  @override
  String get porfolioDetailsTitle => 'Деталі портфеля';

  @override
  String get assetBtc => 'BTC';

  @override
  String assetAmountBtc(double amount) {
    return 'Кількість: $amount BTC';
  }

  @override
  String get assetAapl => 'AAPL';

  @override
  String assetAmountAapl(int amount) {
    return 'Кількість: $amount';
  }

  @override
  String get assetDetailsTitle => 'Деталі активу';

  @override
  String get assetDetailsDummy => 'Тестові деталі активу';
}
