import 'package:flutter/material.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/services/currency_manager.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTab)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [_LanguageSelector(), SizedBox(height: 16), _CurrencySelector()],
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeManager = context.watch<LocaleManager>();
    final currentLocale = localeManager.locale;

    return DropdownButtonFormField<String>(
      value: currentLocale.languageCode,
      decoration: InputDecoration(labelText: l10n.language, border: const OutlineInputBorder()),
      items: [
        DropdownMenuItem(value: 'en', child: Text('English')),
        DropdownMenuItem(value: 'uk', child: Text('Українська')),
      ],
      onChanged: (code) {
        if (code != null) {
          localeManager.setLocale(Locale(code));
        }
      },
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  const _CurrencySelector();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currencyManager = context.watch<CurrencyManager>();

    return DropdownButtonFormField<Currency>(
      value: currencyManager.currency,
      decoration: InputDecoration(labelText: l10n.currency, border: const OutlineInputBorder()),
      items: Currency.values.map((currency) {
        return DropdownMenuItem(
          value: currency,
          child: Text('${currency.symbol} ${currency.code}'),
        );
      }).toList(),
      onChanged: (currency) {
        if (currency != null) {
          currencyManager.updateCurrency(currency);
        }
      },
    );
  }
}
