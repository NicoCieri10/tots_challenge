/// Thrown if an exception occurs while making an dio request.
class DioException implements Exception {}

/// Thrown if an dio request returns a non-200 status code.
class DioRequestFailure implements Exception {
  /// Class constructor.
  const DioRequestFailure(this.statusCode, this.error);

  /// The status code of the response.
  final int statusCode;

  /// The error message of the response.
  final String error;

  @override
  String toString() =>
      'DioRequestFailure(statusCode: $statusCode, error: $error)';
}

/// Thrown when an error occurs while decoding the response body.
class ResponseDecodeException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const ResponseDecodeException();
}

/// Thrown when an error occurs while decoding the response body.
class SpecifiedTypeNotMatchedException implements Exception {
  /// Thrown when an error occurs while decoding the response body.
  const SpecifiedTypeNotMatchedException();
}
