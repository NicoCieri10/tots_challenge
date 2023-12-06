import 'package:app_client/app_client.dart';
import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';

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

  Future<void> logout() async {
    await _dataPersistenceRepository.logout();

    emit(
      state.copyWith(status: HomeStatus.initial),
    );
  }
}
