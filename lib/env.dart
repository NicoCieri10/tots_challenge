import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  const Env._();

  static final _baseUrl = dotenv.env['BASE_URL'];

  /// Method to get the Base Url
  static String? get baseUrl => _baseUrl;
}
