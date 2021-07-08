part of 'resend_code_register_cubit.dart';

abstract class ResendCodeRegisterState extends Equatable {
  const ResendCodeRegisterState();

  @override
  List<Object> get props => [];
}

class ResendCodeRegisterInitialState extends ResendCodeRegisterState {}

class ResendCodeRegisterLoadingState extends ResendCodeRegisterState {}

class ResendCodeRegisterErrorState extends ResendCodeRegisterState {
  final String message;

  ResendCodeRegisterErrorState({this.message});

  List<Object> get props => [message];
}

class ResendCodeRegisterLoadedState extends ResendCodeRegisterState {
  final String message;

  ResendCodeRegisterLoadedState({this.message});

  List<Object> get props => [message];
}
