import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tots_challenge/app/app.dart';
import 'package:tots_challenge/bootstrap.dart';

void main() {
  bootstrap(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final dataPersistenceRepository = DataPersistenceRepository();
      await dataPersistenceRepository.init();

      await dotenv.load(fileName: 'lib/.env');

      return App(dataPersistenceRepository: dataPersistenceRepository);
    },
  );
}
