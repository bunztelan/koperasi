part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckkoutErrorState extends CheckoutState {
  final String message;

  CheckkoutErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class CheckoutLoadedState extends CheckoutState {}
