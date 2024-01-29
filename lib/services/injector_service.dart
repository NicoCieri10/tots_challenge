import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tots_challenge/dio_client.dart';

GetIt getIt = GetIt.instance;

/// Service to inject dependencies
class InjectorService {
  /// Method to initialize the service
  static void init() => getIt.registerLazySingleton<Dio>(getDioClient);
}
