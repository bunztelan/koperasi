part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInErrorState extends SignInState {
  final String message;
  SignInErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class SignInLoadedState extends SignInState {
  final User user;
  SignInLoadedState(this.user);

  @override
  List<Object> get props => [user];
}
