// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Portfolio Tracker';

  @override
  String get portfolioTab => 'Portfolio';

  @override
  String get marketsTab => 'Markets';

  @override
  String get analyticsTab => 'Analytics';

  @override
  String get profileTab => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get changeLanguage => 'Change language:';

  @override
  String get portfolioDetailsTitle => 'Portfolio Details';

  @override
  String get assetBtc => 'BTC';

  @override
  String assetAmountBtc(double amount) {
    return 'Amount: $amount BTC';
  }

  @override
  String get assetAapl => 'AAPL';

  @override
  String assetAmountAapl(int amount) {
    return 'Amount: $amount';
  }

  @override
  String get assetDetailsTitle => 'Asset Details';

  @override
  String get assetDetailsDummy => 'Dummy asset details';
}
