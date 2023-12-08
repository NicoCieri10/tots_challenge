import 'package:app_client/app_client.dart';

/// A model for the response from the API.
class DeleteResponse {
  /// Creates a new response model.
  DeleteResponse({
    required this.success,
    this.response,
    this.error,
  });

  /// Creates a new response model from a map.
  factory DeleteResponse.fromMap(JSON map) {
    return DeleteResponse(
      success: map['success'] as bool,
      response: map['response'] as bool?,
      error: map['error'] as JSON?,
    );
  }

  /// Status of the response.
  final bool success;

  /// The response from the API.
  final bool? response;

  /// The error from the API.
  final JSON? error;
}
