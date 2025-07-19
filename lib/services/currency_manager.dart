import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Currency {
  usd('USD', '\$'),
  eur('EUR', '€'),
  uah('UAH', '₴');

  const Currency(this.code, this.symbol);
  final String code;
  final String symbol;
}

class CurrencyManager extends ChangeNotifier {
  static const _boxName = 'settings';
  static const _currencyKey = 'currency';

  Currency _currency = Currency.usd;
  Currency get currency => _currency;

  Future<void> loadCurrency() async {
    final box = await Hive.openBox(_boxName);
    final savedCurrency = box.get(_currencyKey);
    if (savedCurrency != null) {
      _currency = Currency.values.firstWhere(
        (c) => c.code == savedCurrency,
        orElse: () => Currency.usd,
      );
    }
  }

  Future<void> updateCurrency(Currency newCurrency) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_currencyKey, newCurrency.code);
    _currency = newCurrency;
    notifyListeners();
  }
}
