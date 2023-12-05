part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  attempting,
  success,
  failure,
  badCredentials,
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
  });

  bool get isInitial => status == LoginStatus.initial;
  bool get isAttempting => status == LoginStatus.attempting;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;
  bool get isBadCredentials => status == LoginStatus.badCredentials;

  final LoginStatus status;

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
