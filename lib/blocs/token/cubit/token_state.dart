part of 'token_cubit.dart';

abstract class TokenState extends Equatable {
  String token;

  TokenState({this.token = ''});

  @override
  List<Object> get props => [token];
}

class TokenInitialState extends TokenState {}

class TokenLoadingState extends TokenState {}

class TokenErrorState extends TokenState {
  final String message;

  TokenErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class TokenLoadedState extends TokenState {
  String token;

  TokenLoadedState({this.token}) : super(token: token);

  @override
  List<Object> get props => [token];
}
