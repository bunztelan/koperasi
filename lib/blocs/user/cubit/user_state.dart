part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  final User user;
  const UserState(this.user);

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  UserInitialState() : super(null);
}

class UserLoadingState extends UserState {
  UserLoadingState() : super(null);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({this.message}) : super(null);

  @override
  List<Object> get props => [message];
}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user) : super(user);

  @override
  List<Object> get props => [user];
}
