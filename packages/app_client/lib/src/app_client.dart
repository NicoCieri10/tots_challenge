import 'package:app_client/app_client.dart';
import 'package:app_client/models/auth_user.dart';
import 'package:dio/dio.dart' as dio;

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
      body: {
        'email': email,
        'password': password,
      },
    );

    try {
      return AuthUser.fromMap(response);
    } on FormatException {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// This method creates a new [].
  Future<void> createClient({
    required String title,
    required String body,
  }) async {
    const path = '$clientPath/save';

    await _post<JSON>(
      path,
      body: {
        'title': title,
        'body': body,
        'userId': 1,
      },
    );

    try {
      // return Post.fromMap(result);
    } on FormatException {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  Future<T> _post<T>(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) async {
    final dio.Response<JSON> response;

    try {
      response = await _dio.post(
        path,
        data: body,
        queryParameters: queryParams,
      );
      // return _handleResponse<T>(response);
      // TODO: handle response
      return response as T;
    } catch (e) {
      print(e);
      throw dio.DioException(
        requestOptions: dio.RequestOptions(
          path: path,
          data: body,
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
