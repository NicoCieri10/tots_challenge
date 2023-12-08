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
    emit(state.copyWith(status: HomeStatus.attempting));

    try {
      final result = await InternetConnectionChecker().hasConnection;

      if (result) return await getClients();

      final clients = _dataPersistenceRepository.clients;

      emit(
        state.copyWith(
          status: HomeStatus.offline,
          clients: clients,
          filteredClients: clients,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> refresh() async {
    emit(const HomeState());
    await init();
  }

  Future<void> logout() async => _dataPersistenceRepository.logout();

  Future<void> getClients() async {
    if (state.isOffline) return;
    emit(state.copyWith(status: HomeStatus.attempting));

    try {
      final newClients = await _appClient.getClients(
        token: _dataPersistenceRepository.token!,
      );

      await _dataPersistenceRepository.setClients(clients: newClients);

      emit(
        state.copyWith(
          status: HomeStatus.success,
          clients: newClients,
          filteredClients: newClients,
          page: 1,
        ),
      );
    } catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }

  Future<void> getMoreClients(int page) async {
    if (state.isOffline) return;
    emit(
      state.copyWith(status: HomeStatus.loadingMore),
    );

    try {
      final newClients = await _appClient.getClients(
        token: _dataPersistenceRepository.token!,
        page: page.toString(),
      );

      await _dataPersistenceRepository.setClients(clients: newClients);

      emit(
        state.copyWith(
          status: HomeStatus.success,
          clients: newClients,
          filteredClients: newClients,
          page: page,
        ),
      );
    } catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }

  Future<void> createClient(Client? client) async {
    if (state.isOffline) return;

    emit(state.copyWith(status: HomeStatus.attempting));

    try {
      await _appClient.createClient(
        token: _dataPersistenceRepository.token!,
        client: client!,
      );

      await getClients();

      emit(state.copyWith(status: HomeStatus.success));
    } catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }

  Future<void> updateClient(Client? client) async {
    if (state.isOffline) return;

    emit(state.copyWith(status: HomeStatus.attempting));

    try {
      await _appClient.updateClient(
        token: _dataPersistenceRepository.token!,
        client: client!,
      );

      await getClients();

      emit(state.copyWith(status: HomeStatus.success));
    } catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }

  Future<void> deleteClient(Client client) async {
    if (state.isOffline) return;

    emit(state.copyWith(status: HomeStatus.attempting));

    try {
      await _appClient.removeClient(
        token: _dataPersistenceRepository.token!,
        id: client.id.toString(),
      );

      await getClients();

      emit(state.copyWith(status: HomeStatus.success));
    } catch (_) {
      await InternetConnectionChecker().hasConnection
          ? emit(state.copyWith(status: HomeStatus.failure))
          : emit(state.copyWith(status: HomeStatus.offline));
    }
  }

  void searchClient(String query) {
    emit(state.copyWith(status: HomeStatus.attempting));

    if (query.isEmpty) {
      emit(
        state.copyWith(
          status: HomeStatus.success,
          filteredClients: state.clients,
        ),
      );
    } else {
      final filteredClients = state.clients
          .where(
            (client) => '''
${client.firstname ?? ''} ${client.lastname ?? ''} ${client.email ?? ''}
'''
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();

      emit(
        state.copyWith(
          status: HomeStatus.success,
          filteredClients: filteredClients,
        ),
      );
    }
  }
}
