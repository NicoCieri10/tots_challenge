import 'package:dio/dio.dart';
import 'package:tots_challenge/configs/configs.dart';

/// Client to make requests to the API
class DioClient {
  /// Client to make requests to the API
  const DioClient();

  Dio instance() {
    final options = BaseOptions(
      baseUrl: Env.baseUrl ?? '',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 6),
    );

    final dio = Dio(options);

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        responseBody: true,
        responseHeader: false,
      ),
    );

    return dio;
  }
}
