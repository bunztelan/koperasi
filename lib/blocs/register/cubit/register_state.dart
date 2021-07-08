part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({this.message});

  List<Object> get props => [message];
}

class RegisterLoadedState extends RegisterState {
  final String message;
  final String userId;

  RegisterLoadedState({this.userId, this.message});

  List<Object> get props => [message];
}
