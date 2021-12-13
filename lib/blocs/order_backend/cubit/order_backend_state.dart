part of 'order_backend_cubit.dart';

abstract class OrderBackendState extends Equatable {
  const OrderBackendState();

  @override
  List<Object> get props => [];
}

class OrderBackendInitialState extends OrderBackendState {}

class OrderBackendLoadingState extends OrderBackendState {}

class OrderBackendErrorState extends OrderBackendState {
  final String message;

  OrderBackendErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class OrderBackendLoadedState extends OrderBackendState {
  final List<OrderedItem> orders;

  OrderBackendLoadedState({this.orders});

  @override
  List<Object> get props => [orders];
}
