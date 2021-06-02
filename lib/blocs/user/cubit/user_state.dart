part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user);

  @override
  List<Object> get props => [user];
}
