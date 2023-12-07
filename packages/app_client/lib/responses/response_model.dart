/// A model for the response from the API.
class ResponseModel {
  /// Creates a new response model.
  ResponseModel({
    required this.success,
    this.response,
    this.error,
  });

  /// Creates a new response model from a map.
  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      success: map['success'] as bool,
      response: map['response'] as Map<String, dynamic>?,
      error: map['error'] as Map<String, dynamic>?,
    );
  }

  /// Status of the response.
  final bool success;

  /// The response from the API.
  final Map<String, dynamic>? response;

  /// The error from the API.
  final Map<String, dynamic>? error;
}
