import 'package:dio/dio.dart';
import 'package:porfolio/core/network/api_result.dart';
import 'package:porfolio/core/network/basic_network_error.dart';

class NetworkService {
  NetworkService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
  }

  late final Dio _dio;

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: queryParameters, options: options);

      return ApiResult.success(data: response.data as T);
    } on DioException catch (e) {
      return ApiResult.error(_handleDioError(e));
    } catch (e) {
      return ApiResult.error(BasicNetworkError.serverError(e.toString()));
    }
  }

  BasicNetworkError _handleDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const BasicNetworkError.timeout(),

      DioExceptionType.connectionError => const BasicNetworkError.noInternet(),

      DioExceptionType.badResponse => switch (error.response?.statusCode) {
        401 => const BasicNetworkError.unauthorized(),
        404 => const BasicNetworkError.notFound(),
        _ => BasicNetworkError.serverError(error.response?.data?.toString() ?? error.message),
      },

      DioExceptionType.cancel ||
      DioExceptionType.badCertificate ||
      DioExceptionType.unknown => BasicNetworkError.serverError(error.message),
    };
  }
}
