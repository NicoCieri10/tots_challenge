import 'package:app_client/app_client.dart';
import 'package:app_client/responses/response_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

/// The JSON serializable model for the API response.
typedef JSON = Map<String, dynamic>;

/// When de API response is a List of [JSON].
typedef JSONLIST = List<JSON>;

/// APP Client to manage the API requests.
class AppClient {
  /// Class constructor
  AppClient({required dio.Dio dioClient}) : _dio = dioClient;

  /// Dio instance
  final dio.Dio _dio;

  /// The client path for the queries.
  static const clientPath = '/client';

  /// The auth path for the queries.
  static const authPath = '/mia-auth';

  /// This method is used to login the user.
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    const path = '$authPath/login';

    final response = await _post<JSON>(
      path,
      data: {
        'email': email,
        'password': password,
      },
    );

    try {
      final responseModel = ResponseModel.fromMap(response);
      if (responseModel.success) {
        return AuthUser.fromMap(responseModel.response!);
      } else {
        throw DioRequestFailure(
          responseModel.error!['code'] as int,
          responseModel.error!['message'] as String,
        );
      }
    } on FormatException {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// This method creates a new [Client].
  Future<Client> createClient({
    required Client client,
    required String token,
  }) async {
    const path = '$clientPath/save';

    final response = await _post<JSON>(
      path,
      options: {'Authorization': 'Bearer $token'},
      data: client.toMap(),
    );

    try {
      final responseModel = ResponseModel.fromMap(response);
      if (responseModel.success) {
        return Client.fromMap(responseModel.response!);
      } else {
        throw DioRequestFailure(
          responseModel.error!['code'] as int,
          responseModel.error!['message'] as String,
        );
      }
    } on FormatException {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// This method updates an existing [Client].
  Future<Client> updateClient({
    required Client client,
    required String token,
  }) async {
    const path = '$clientPath/save';

    final response = await _post<JSON>(
      path,
      options: {'Authorization': 'Bearer $token'},
      data: client.toMap(),
    );

    try {
      final responseModel = ResponseModel.fromMap(response);
      if (responseModel.success) {
        return Client.fromMap(responseModel.response!);
      } else {
        throw DioRequestFailure(
          responseModel.error!['code'] as int,
          responseModel.error!['message'] as String,
        );
      }
    } on FormatException {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  Future<T> _post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? queryParams,
    Map<String, String>? options,
  }) async {
    final dio.Response<JSON> response;

    try {
      response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: options),
      );
      return _handleResponse<T>(response);
    } catch (e) {
      throw dio.DioException(
        requestOptions: dio.RequestOptions(
          path: path,
          data: data,
          queryParameters: queryParams,
        ),
      );
    }
  }

  T _handleResponse<T>(dio.Response<JSON> response) {
    try {
      if (response is T) return response as T;

      if (response.isFailure && response.data is Map<String, dynamic>) {
        if (response.data!.containsKey('exception')) {
          // throw ExceptionResponse.fromMap(decodedResponse);
        }
        throw DioRequestFailure(
          response.statusCode!,
          response.statusMessage ?? '',
        );
      }

      if (response.data is T) return response.data as T;

      try {
        if (T == JSON) {
          (response.data!).cast<String, dynamic>() as T;
        } else if (T == JSONLIST) {
          final newResponse = (response.data! as List)
              .map<JSON>(
                (dynamic item) => (item as Map).cast<String, dynamic>(),
              )
              .toList();
          return newResponse as T;
        }

        return response.data as T;
      } catch (_) {
        throw const SpecifiedTypeNotMatchedException();
      }
    } on FormatException {
      throw const ResponseDecodeException();
    }
  }
}

/// A class to make it easier to handle the response from the API.
extension Result on dio.Response<JSON> {
  /// Returns true if the response is a success.
  bool get isSuccess => statusCode! >= 200 && statusCode! < 300;

  /// Returns true if the response is a failure.
  bool get isFailure => !isSuccess;
}
