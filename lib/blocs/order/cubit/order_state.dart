part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderErrorState extends OrderState {
  final String message;

  OrderErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class OrderLoadedState extends OrderState {
  final List<Order> orders;

  OrderLoadedState({this.orders});

  @override
  List<Object> get props => [orders];
}
