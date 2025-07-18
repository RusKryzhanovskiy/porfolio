import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/core/cache/cache_service.dart';
import 'package:portfolio/core/network/api_result.dart';
import 'package:portfolio/core/network/network_service.dart';

abstract class BaseRepository {
  final NetworkService _networkService;
  final CacheService _cacheService;

  BaseRepository({required NetworkService networkService, required CacheService cacheService})
    : _networkService = networkService,
      _cacheService = cacheService;

  /// Fetches data with offline-first approach
  ///
  /// [endpoint] - API endpoint
  /// [params] - Query parameters
  /// [forceRefresh] - If true, ignores cache and fetches from network
  /// [maxAge] - Maximum age of cached data, null means no expiration
  /// [mapData] - Function to map raw data to desired type
  Future<ApiResult<T>> fetchData<T, R>({
    required String endpoint,
    Map<String, dynamic>? params,
    bool forceRefresh = false,
    Duration? maxAge,
    Options? options,
    required T Function(R data) mapData,
  }) async {
    // Try to get cached data first if not forcing refresh
    if (!forceRefresh) {
      final cachedData = await _cacheService.getCachedData<R>(
        endpoint: endpoint,
        params: params,
        maxAge: maxAge,
      );

      if (cachedData != null) {
        return ApiResult.success(data: mapData(cachedData));
      }
    }

    // If no cached data or force refresh, fetch from network
    final result = await _networkService.get<R>(
      endpoint,
      queryParameters: params,
      options: options,
    );

    return switch (result) {
      Success(data: final data) => await _handleSuccess(
        endpoint: endpoint,
        params: params,
        data: data,
        mapData: mapData,
      ),
      Error(error: final error) => ApiResult.error(error),
    };
  }

  Future<ApiResult<T>> _handleSuccess<T, R>({
    required String endpoint,
    required Map<String, dynamic>? params,
    required R data,
    required T Function(R data) mapData,
  }) async {
    // Map the data first to ensure it's valid
    final mappedData = mapData(data);

    // Try to cache the raw data, but don't let cache failures affect the result
    try {
      await _cacheService.cacheData(endpoint: endpoint, params: params, data: data);
    } catch (e) {
      // Log the cache error but don't fail the operation
      debugPrint('Cache error: $e');
    }

    // Return the mapped data regardless of cache success
    return ApiResult.success(data: mappedData);
  }
}
