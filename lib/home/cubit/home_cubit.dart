import 'package:app_client/app_client.dart';
import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required AppClient appClient,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _appClient = appClient,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(const HomeState());

  final DataPersistenceRepository _dataPersistenceRepository;
  final AppClient _appClient;

  Future<void> init() async {
    emit(
      state.copyWith(status: HomeStatus.attempting),
    );

    try {
      final result = await InternetConnectionChecker().hasConnection;

      if (result) return await getClients();

      final clients = _dataPersistenceRepository.clients;

      emit(
        state.copyWith(
          status: HomeStatus.offline,
          clients: clients,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.failure),
      );
    }
  }

  Future<void> refresh() async {
    emit(const HomeState());
    await init();
  }

  Future<void> logout() async => _dataPersistenceRepository.logout();

  Future<void> getClients() async {
    if (state.isOffline) return;
    emit(
      state.copyWith(status: HomeStatus.loadingMore),
    );

    try {
      final newClients = await _appClient.getClients(
        token: _dataPersistenceRepository.token!,
      );

      emit(
        state.copyWith(
          status: HomeStatus.success,
          clients: newClients,
        ),
      );
    } on DioRequestFailure catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }
}
