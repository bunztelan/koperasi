part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordErrorState extends ChangePasswordState {
  final String message;

  ChangePasswordErrorState({this.message});

  List<Object> get props => [message];
}

class ChangePasswordLoadedState extends ChangePasswordState {
  final String message;

  ChangePasswordLoadedState({this.message});

  List<Object> get props => [message];
}
