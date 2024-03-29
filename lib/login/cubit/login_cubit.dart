import 'package:app_client/app_client.dart';
import 'package:bloc/bloc.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AppClient appClient,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _appClient = appClient,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(const LoginState());

  final DataPersistenceRepository _dataPersistenceRepository;
  final AppClient _appClient;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: LoginStatus.attempting));

    try {
      final authUser = await _appClient.login(
        email: email,
        password: password,
      );

      await _dataPersistenceRepository.setLoggedIn(status: true);
      await _dataPersistenceRepository.setUser(user: authUser);
      await _dataPersistenceRepository.setToken(token: authUser.accessToken);

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.badCredentials));
    }
  }

  Future<void> logout() async {
    await _dataPersistenceRepository.logout();

    emit(state.copyWith(status: LoginStatus.initial));
  }
}
