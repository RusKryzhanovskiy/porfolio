import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/network/api_result.dart';
import 'package:portfolio/core/network/basic_network_error.dart';
import 'package:portfolio/features/markets/data/crypto_markets_repository.dart';
import 'package:portfolio/features/markets/presentation/cubit/markets_state.dart';
import 'package:portfolio/services/currency_manager.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit({
    required CryptoMarketsRepository cryptoMarketsRepository,
    required CurrencyManager currencyManager,
  }) : _repository = cryptoMarketsRepository,
       _currencyManager = currencyManager,
       super(const MarketsInitial()) {
    // Listen to currency changes
    _currencyManager.addListener(_onCurrencyChanged);
  }

  final CryptoMarketsRepository _repository;
  final CurrencyManager _currencyManager;

  @override
  Future<void> close() {
    _currencyManager.removeListener(_onCurrencyChanged);
    return super.close();
  }

  void _onCurrencyChanged() {
    loadCryptoMarkets(forceRefresh: true);
  }

  Future<void> loadCryptoMarkets({bool forceRefresh = false}) async {
    emit(const MarketsLoading());

    final currency = _currencyManager.currency;
    final result = await _repository.getTopCryptos(
      limit: 100,
      forceRefresh: forceRefresh,
      currency: currency.code,
    );

    emit(switch (result) {
      Success(data: final cryptos) => MarketsLoaded(cryptos: cryptos),
      Error(error: final error) => switch (error) {
        ServerError(details: final details?) => MarketsError(message: details),
        NoInternetError() when !forceRefresh => MarketsError(
          message: 'No internet connection. Showing cached data.',
        ),
        _ => const MarketsError(message: 'Failed to load crypto markets'),
      },
    });
  }
}
