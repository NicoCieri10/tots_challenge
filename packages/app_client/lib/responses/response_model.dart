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

// import 'dart:developer';

// import 'package:app_client/app_client.dart';

// /// A model for the response from the API.
// class ResponseModel {
//   /// Creates a new response model.
//   ResponseModel({
//     required this.success,
//     this.response,
//     this.error,
//   });

//   /// Creates a new response model from a map.
//   factory ResponseModel.fromMap(JSON map) {
//     try {
//       final response = ResponseModel(
//         success: map['success'] as bool,
//         response: map['response'] == null
//             ? null
//             : Response.fromMap(map['response'] as JSON),
//         error: map['error'] as JSON?,
//       );
//       return response;
//     } catch (e) {
//       log(e.toString());
//       throw const FormatException();
//     }
//   }

//   /// Status of the response.
//   final bool success;

//   /// The response from the API.
//   final Response? response;

//   /// The error from the API.
//   final JSON? error;
// }

// /// A model for the response from the API.
// class Response {
//   /// Creates a new response.
//   Response({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });

//   /// Creates a new response from a map.
//   factory Response.fromMap(JSON json) => Response(
//         currentPage: json['current_page'] as int?,
//         data: json['data'] as List<JSON>?,
//         firstPageUrl: json['first_page_url'] as String?,
//         from: json['from'] as int?,
//         lastPage: json['last_page'] as int?,
//         lastPageUrl: json['last_page_url'] as String?,
//         links: json['links'] as List<JSON>?,
//         nextPageUrl: json['next_page_url'] as String?,
//         path: json['path'] as String?,
//         perPage: json['per_page'] as int?,
//         prevPageUrl: json['prev_page_url'] as dynamic,
//         to: json['to'] as int?,
//         total: json['total'] as int?,
//       );

//   /// Creates a new response from a map.
//   final int? currentPage;

//   /// The response from the API.
//   final List<JSON>? data;

//   /// The error from the API.
//   final String? firstPageUrl;

//   /// The error from the API.
//   final int? from;

//   /// The error from the API.
//   final int? lastPage;

//   /// The error from the API.
//   final String? lastPageUrl;

//   /// The error from the API.
//   final List<JSON>? links;

//   /// The error from the API.
//   final String? nextPageUrl;

//   /// The error from the API.
//   final String? path;

//   /// The error from the API.
//   final int? perPage;

//   /// The error from the API.
//   final dynamic prevPageUrl;

//   /// The error from the API.
//   final int? to;

//   /// The error from the API.
//   final int? total;
// }

