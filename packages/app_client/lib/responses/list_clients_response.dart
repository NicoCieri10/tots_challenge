import 'dart:developer';

import 'package:app_client/app_client.dart';

/// A model for the response from the API.
class ListClientsResponse {
  /// Creates a new response model.
  ListClientsResponse({
    required this.success,
    this.response,
    this.error,
  });

  /// Creates a new response model from a map.
  factory ListClientsResponse.fromMap(JSON map) {
    try {
      final response = ListClientsResponse(
        success: map['success'] as bool,
        response: map['response'] == null
            ? null
            : ClientsResponse.fromMap(map['response'] as JSON),
        error: map['error'] as JSON?,
      );
      return response;
    } catch (e) {
      log('ListClientsResponse from map: $e');
      throw const FormatException();
    }
  }

  /// Status of the response.
  final bool success;

  /// The response from the API.
  final ClientsResponse? response;

  /// The error from the API.
  final JSON? error;
}

/// A model for the response from the API.
class ClientsResponse {
  /// Creates a new response.
  ClientsResponse({
    this.currentPage,
    this.clients,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  /// Creates a new response from a map.
  factory ClientsResponse.fromMap(JSON json) {
    try {
      return ClientsResponse(
        currentPage: json['current_page'] as int?,
        clients: (json['data'] as List)
            .cast<Map<dynamic, dynamic>>()
            .map((client) => client.cast<String, dynamic>())
            .map(Client.fromMap)
            .toList(),
        firstPageUrl: json['first_page_url'] as String?,
        from: json['from'] as int?,
        lastPage: json['last_page'] as int?,
        lastPageUrl: json['last_page_url'] as String?,
        links: (json['links'] as List)
            .cast<Map<dynamic, dynamic>>()
            .map((link) => link.cast<String, dynamic>())
            .map(Link.fromMap)
            .toList(),
        nextPageUrl: json['next_page_url'] as String?,
        path: json['path'] as String?,
        perPage: json['per_page'] as String?,
        prevPageUrl: json['prev_page_url'] as String?,
        to: json['to'] as int?,
        total: json['total'] as int?,
      );
    } catch (e) {
      log('ClientsResponse from map: $e');
      throw const FormatException();
    }
  }

  /// Creates a new response from a map.
  final int? currentPage;

  /// The response from the API.
  final List<Client>? clients;

  /// The error from the API.
  final String? firstPageUrl;

  /// The error from the API.
  final int? from;

  /// The error from the API.
  final int? lastPage;

  /// The error from the API.
  final String? lastPageUrl;

  /// The error from the API.
  final List<Link>? links;

  /// The error from the API.
  final String? nextPageUrl;

  /// The error from the API.
  final String? path;

  /// The error from the API.
  final String? perPage;

  /// The error from the API.
  final String? prevPageUrl;

  /// The error from the API.
  final int? to;

  /// The error from the API.
  final int? total;
}
