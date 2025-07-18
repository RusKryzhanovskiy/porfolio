sealed class BasicNetworkError {
  const BasicNetworkError();

  const factory BasicNetworkError.noInternet() = NoInternetError;
  const factory BasicNetworkError.timeout() = TimeoutError;
  const factory BasicNetworkError.serverError([String? details]) = ServerError;
  const factory BasicNetworkError.unauthorized() = UnauthorizedError;
  const factory BasicNetworkError.notFound() = NotFoundError;
}

final class NoInternetError extends BasicNetworkError {
  const NoInternetError();
}

final class TimeoutError extends BasicNetworkError {
  const TimeoutError();
}

final class ServerError extends BasicNetworkError {
  final String? details;

  const ServerError([this.details]);
}

final class UnauthorizedError extends BasicNetworkError {
  const UnauthorizedError();
}

final class NotFoundError extends BasicNetworkError {
  const NotFoundError();
}
