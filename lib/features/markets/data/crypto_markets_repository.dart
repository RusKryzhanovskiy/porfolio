import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:porfolio/core/network/api_result.dart';
import 'package:porfolio/core/repository/base_repository.dart';
import 'package:porfolio/features/markets/domain/models/crypto_market_data.dart';

class CryptoMarketsRepository extends BaseRepository {
  CryptoMarketsRepository({required super.networkService, required super.cacheService});

  static const _baseUrl = 'https://pro-api.coinmarketcap.com/v1';

  String get _apiKey => dotenv.env['COINMARKETCAP_API_KEY'] ?? '';

  Future<ApiResult<List<CryptoMarketData>>> getTopCryptos({
    int limit = 100,
    bool forceRefresh = false,
    String currency = 'USD',
  }) async {
    return fetchData<List<CryptoMarketData>, Map<String, dynamic>>(
      endpoint: '$_baseUrl/cryptocurrency/listings/latest',
      params: {'limit': limit, 'convert': currency},
      options: Options(headers: {'X-CMC_PRO_API_KEY': _apiKey}),
      forceRefresh: forceRefresh,
      maxAge: const Duration(minutes: 15),
      mapData: (data) => (data['data'] as List)
          .map(
            (crypto) =>
                CryptoMarketData.fromJson(crypto as Map<String, dynamic>, currency: currency),
          )
          .toList(),
    );
  }
}
