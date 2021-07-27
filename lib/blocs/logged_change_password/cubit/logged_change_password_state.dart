part of 'logged_change_password_cubit.dart';

abstract class LCPasswordState extends Equatable {
  const LCPasswordState();

  @override
  List<Object> get props => [];
}

class LCPasswordInitialState extends LCPasswordState {}

class LCPasswordLoadingState extends LCPasswordState {}

class LCPasswordErrorState extends LCPasswordState {
  final String message;

  LCPasswordErrorState({this.message});

  List<Object> get props => [message];
}

class LCPasswordLoadedState extends LCPasswordState {
  final String message;

  LCPasswordLoadedState({this.message});

  List<Object> get props => [message];
}
