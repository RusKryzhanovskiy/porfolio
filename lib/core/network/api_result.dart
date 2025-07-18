import 'package:porfolio/core/network/basic_network_error.dart';

sealed class ApiResult<T> {
  const ApiResult();

  const factory ApiResult.success({required T data}) = Success;
  const factory ApiResult.error(BasicNetworkError error) = Error;
}

final class Success<T> extends ApiResult<T> {
  final T data;

  const Success({required this.data});
}

final class Error<T> extends ApiResult<T> {
  final BasicNetworkError error;

  const Error(this.error);
}
