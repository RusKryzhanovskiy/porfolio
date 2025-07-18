import 'package:portfolio/features/markets/domain/models/crypto_market_data.dart';

sealed class MarketsState {
  const MarketsState();
}

final class MarketsInitial extends MarketsState {
  const MarketsInitial();
}

final class MarketsLoading extends MarketsState {
  const MarketsLoading();
}

final class MarketsLoaded extends MarketsState {
  final List<CryptoMarketData> cryptos;

  const MarketsLoaded({required this.cryptos});
}

final class MarketsError extends MarketsState {
  final String message;

  const MarketsError({required this.message});
}
