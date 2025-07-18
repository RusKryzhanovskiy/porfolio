import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/modules/markets/domain/models/crypto_market_data.dart';
import 'package:portfolio/modules/markets/presentation/cubit/markets_cubit.dart';
import 'package:portfolio/modules/markets/presentation/cubit/markets_state.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/services/currency_manager.dart';

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.marketsTab)),
      body: RefreshIndicator(
        onRefresh: () => context.read<MarketsCubit>().loadCryptoMarkets(forceRefresh: true),
        child: BlocBuilder<MarketsCubit, MarketsState>(
          builder: (context, state) => switch (state) {
            MarketsLoading() => const Center(child: CircularProgressIndicator()),
            MarketsError(message: final message) => Center(child: Text(message)),
            MarketsLoaded(cryptos: final cryptos) => _CryptoList(cryptos: cryptos),
            MarketsInitial() => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _CryptoList extends StatelessWidget {
  const _CryptoList({required this.cryptos});

  final List<CryptoMarketData> cryptos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptos.length,
      itemBuilder: (context, index) {
        final crypto = cryptos[index];
        return ListTile(
          title: Text(crypto.name),
          subtitle: Text(crypto.symbol),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(
                builder: (context) {
                  final currencyManager = context.watch<CurrencyManager>();
                  return Text(
                    '${currencyManager.currency.symbol}${crypto.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
              Text(
                '${crypto.change24h.toStringAsFixed(2)}%',
                style: TextStyle(color: crypto.change24h >= 0 ? Colors.green : Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
