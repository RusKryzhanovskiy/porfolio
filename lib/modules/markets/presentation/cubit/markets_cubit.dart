import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/network/api_result.dart';
import 'package:portfolio/modules/markets/data/crypto_markets_repository.dart';
import 'package:portfolio/modules/markets/presentation/cubit/markets_state.dart';
import 'package:portfolio/services/currency_manager.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit({
    required ICryptoMarketsRepository cryptoMarketsRepository,
    required CurrencyManager currencyManager,
  }) : _repository = cryptoMarketsRepository,
       _currencyManager = currencyManager,
       super(const MarketsInitial()) {
    _currencyManager.addListener(_onCurrencyChanged);
  }

  final ICryptoMarketsRepository _repository;
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

    final result = await _repository.getTopCryptos(
      limit: 100,
      forceRefresh: forceRefresh,
      currency: _currencyManager.currency.code,
    );

    switch (result) {
      case Success(data: final cryptos):
        emit(MarketsLoaded(cryptos: cryptos));
        break;
      case Error(error: final error):
        emit(MarketsError(message: '$error'));
        break;
    }
  }
}
