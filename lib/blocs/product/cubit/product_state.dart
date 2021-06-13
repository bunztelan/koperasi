part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({this.products});

  @override
  List<Object> get props => [products];
}
