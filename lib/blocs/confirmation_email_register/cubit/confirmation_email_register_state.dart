part of 'confirmation_email_register_cubit.dart';

abstract class CERegisterState extends Equatable {
  const CERegisterState();

  @override
  List<Object> get props => [];
}

class CERegisterInitialState extends CERegisterState {}

class CERegisterLoadingState extends CERegisterState {}

class CERegisterErrorState extends CERegisterState {
  final String message;

  CERegisterErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class CERegisterLoadedState extends CERegisterState {
  final String message;

  CERegisterLoadedState({this.message});

  @override
  List<Object> get props => [message];
}
