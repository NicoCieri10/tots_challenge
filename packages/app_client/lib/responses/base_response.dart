import 'package:app_client/app_client.dart';

/// A model for the response from the API.
class BaseResponse {
  /// Creates a new response model.
  BaseResponse({
    required this.success,
    this.response,
    this.error,
  });

  /// Creates a new response model from a map.
  factory BaseResponse.fromMap(JSON map) {
    return BaseResponse(
      success: map['success'] as bool,
      response: map['response'] as JSON?,
      error: map['error'] as JSON?,
    );
  }

  /// Status of the response.
  final bool success;

  /// The response from the API.
  final JSON? response;

  /// The error from the API.
  final JSON? error;
}
