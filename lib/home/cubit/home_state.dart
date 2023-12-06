part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  attempting,
  success,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
  });

  final HomeStatus status;

  bool get isInitial => status == HomeStatus.initial;
  bool get isAttempting => status == HomeStatus.attempting;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailure => status == HomeStatus.failure;

  HomeState copyWith({
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [];
}
