part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;

  ForgotPasswordErrorState({this.message});

  List<Object> get props => [message];
}

class ForgotPasswordLoadedState extends ForgotPasswordState {
  final String message;

  ForgotPasswordLoadedState({this.message});

  List<Object> get props => [message];
}
