part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  attempting,
  success,
  failure,
  offline,
  loadingMore,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.clients = const <Client>[],
  });

  final HomeStatus status;
  final List<Client> clients;

  bool get isInitial => status == HomeStatus.initial;
  bool get isAttempting => status == HomeStatus.attempting;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailure => status == HomeStatus.failure;
  bool get isOffline => status == HomeStatus.offline;
  bool get isLoadingMore => status == HomeStatus.loadingMore;

  HomeState copyWith({
    HomeStatus? status,
    List<Client>? clients,
  }) {
    return HomeState(
      status: status ?? this.status,
      clients: clients ?? this.clients,
    );
  }

  @override
  List<Object?> get props => [
        status,
        clients,
      ];
}
