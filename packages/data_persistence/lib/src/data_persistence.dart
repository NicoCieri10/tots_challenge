import 'dart:async';

import 'package:app_client/app_client.dart';
import 'package:data_persistence/src/data_persistence_exceptions.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// This repository handles all the methods regarding to the persistence of data
/// in the app.
class DataPersistenceRepository {
  /// The method that initializes the [Hive] instance.
  Future<void> init() async {
    final directory = await getApplicationSupportDirectory();
    if (!directory.existsSync()) directory.createSync();

    Hive
      ..init(directory.path)
      ..registerAdapter(AuthUserAdapter());

    final completers = <Completer<void>>[];
    for (final key in boxKeys) {
      final completer = Completer<void>();

      if (!Hive.isBoxOpen(key)) {
        completers.add(completer);
        await Hive.openBox<dynamic>(key).catchError((dynamic e) {
          throw DataPersistenceInitException(e as Error);
        });
      }
    }
  }

  /// Get the App Settings box.
  Box<dynamic> get userSessionBox => Hive.box<dynamic>(userSessionKey);

  /// Get the User box.
  Box<dynamic> get userDataBox => Hive.box<dynamic>(userDataKey);

  /// Whether the user is logged in or not.
  bool get isLoggedIn =>
      userSessionBox.get(BoxKeys.isLoggedIn) as bool? ?? false;

  /// Updates the status of the login.
  Future<void> setLoggedIn({bool status = false}) async =>
      userSessionBox.put(BoxKeys.isLoggedIn, status);

  /// Get the user data.
  AuthUser? get user => userDataBox.get(BoxKeys.userData) as AuthUser?;

  /// Updates the user data.
  Future<void> setUser({AuthUser? user}) async =>
      userDataBox.put(BoxKeys.userData, user);

  /// Get the bearer token.
  String? get token => userSessionBox.get(BoxKeys.token) as String?;

  /// Updates the bearer token.
  Future<void> setToken({String? token}) async =>
      userSessionBox.put(BoxKeys.token, token);

  /// Method to clear all the user data.
  Future<void> logout() async {
    await userSessionBox.clear();
    await userDataBox.clear();
  }

  /// The key of the user session box.
  static const userSessionKey = 'user_session';

  /// The key of the user box.
  static const userDataKey = 'user_data';

  /// The list of all the box keys.
  static const boxKeys = {
    userSessionKey,
    userDataKey,
  };
}

/// This class holds all the box keys to access the info inside hive.
class BoxKeys {
  /// The key to access to the user session information.
  static const isLoggedIn = 'is_logged_in';

  /// The key to access to the token information.
  static const token = 'token';

  /// The key to access to the user information.
  static const userData = 'user_data';
}
