import 'package:flutter/material.dart';
import 'package:porfolio/l10n/app_localizations.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.analyticsTab)),
      body: Center(child: Text(l10n.analyticsTab)),
    );
  }
}
