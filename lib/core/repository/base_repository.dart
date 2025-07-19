import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/core/cache/cache_service.dart';
import 'package:portfolio/core/network/api_result.dart';
import 'package:portfolio/core/network/network_service.dart';

enum RequestMethod { get, post, put, delete }

abstract interface class IBaseRepository {
  Future<ApiResult<T>> fetchData<T, R>({
    required String endpoint,
    required RequestMethod method,
    required T Function(R data) mapData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headrers,
    bool forceRefresh = false,
    Duration? maxAge,
  });
}

class BaseRepositoryImpl implements IBaseRepository {
  final NetworkService _networkService;
  final CacheService _cacheService;

  BaseRepositoryImpl ({required NetworkService networkService, required CacheService cacheService})
    : _networkService = networkService,
      _cacheService = cacheService;

  @override
  Future<ApiResult<T>> fetchData<T, R>({
    required String endpoint,
    required RequestMethod method,
    required T Function(R data) mapData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headrers,
    bool forceRefresh = false,
    Duration? maxAge,
  }) async {
    if (!forceRefresh) {
      final cachedData = await _cacheService.getCachedData<R>(
        endpoint: endpoint,
        params: queryParameters,
        maxAge: maxAge,
      );

      if (cachedData != null) {
        return ApiResult.success(data: mapData(cachedData));
      }
    }

    final result = await _networkService.request<R>(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        method: method.name.toUpperCase(),
        responseType: ResponseType.json,
        headers: headrers,
      ),
    );

    return switch (result) {
      Success(data: final data) => await _handleSuccess(
        endpoint: endpoint,
        queryParameters: queryParameters,
        mapData: mapData,
        data: data,
      ),
      Error(error: final error) => ApiResult.error(error),
    };
  }

  Future<ApiResult<T>> _handleSuccess<T, R>({
    required String endpoint,
    required Map<String, dynamic>? queryParameters,
    required T Function(R data) mapData,
    required R data,
  }) async {
    final mappedData = mapData(data);

    try {
      await _cacheService.cacheData(endpoint: endpoint, params: queryParameters, data: data);
    } catch (e) {
      debugPrint('Cache error: $e');
    }

    return ApiResult.success(data: mappedData);
  }
}
