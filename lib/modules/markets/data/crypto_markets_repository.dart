import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio/core/network/api_result.dart';
import 'package:portfolio/core/repository/base_repository.dart';
import 'package:portfolio/modules/markets/domain/models/crypto_market_data.dart';

abstract interface class ICryptoMarketsRepository {
  Future<ApiResult<List<CryptoMarketData>>> getTopCryptos({
    int limit = 100,
    bool forceRefresh = false,
    String currency = 'USD',
  });
}

class CryptoMarketsRepositoryImpl implements ICryptoMarketsRepository {
  CryptoMarketsRepositoryImpl({required IBaseRepository baseRepository})
    : _baseRepository = baseRepository;

  final IBaseRepository _baseRepository;

  static const String _baseUrl = 'https://pro-api.coinmarketcap.com/v1';
  static const String _listingsEndpoint = '$_baseUrl/cryptocurrency/listings/latest';

  @override
  Future<ApiResult<List<CryptoMarketData>>> getTopCryptos({
    int limit = 100,
    bool forceRefresh = false,
    String currency = 'USD',
  }) async {
    return _baseRepository.fetchData<List<CryptoMarketData>, Map<String, dynamic>>(
      method: RequestMethod.get,
      endpoint: _listingsEndpoint,
      forceRefresh: forceRefresh,
      queryParameters: {'limit': limit, 'convert': currency},
      headrers: apiHeaders,
      maxAge: const Duration(hours: 1),
      mapData: (data) {
        return (data['data']).map((crypto) {
          return CryptoMarketData.fromJson(crypto, currency: currency);
        }).toList().cast<CryptoMarketData>();
      },
    );
  }

  Map<String, String> get apiHeaders {
    final apiKey = dotenv.env['COINMARKETCAP_API_KEY'] ?? '';
    return <String, String>{'X-CMC_PRO_API_KEY': apiKey};
  }
}
