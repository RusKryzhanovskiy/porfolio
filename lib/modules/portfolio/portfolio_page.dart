import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.portfolioTab)),
      body: ListView(
        children: [
          ListTile(
            title: Text('${l10n.portfolioTab} #1'),
            subtitle: const Text('Total Balance: 10000 USD'),
            onTap: () {
              context.go('/portfolio/details');
            },
          ),
        ],
      ),
    );
  }
}

class PortfolioDetailsPage extends StatelessWidget {
  const PortfolioDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.portfolioDetailsTitle)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.assetBtc),
            subtitle: Text(l10n.assetAmountBtc(0.5)),
            onTap: () {
              context.goNamed('assetDetails');
            },
          ),
          ListTile(
            title: Text(l10n.assetAapl),
            subtitle: Text(l10n.assetAmountAapl(10)),
            onTap: () {
              context.goNamed('assetDetails');
            },
          ),
        ],
      ),
    );
  }
}

class AssetDetailsPage extends StatelessWidget {
  const AssetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.assetDetailsTitle)),
      body: Center(child: Text(l10n.assetDetailsDummy)),
    );
  }
}
