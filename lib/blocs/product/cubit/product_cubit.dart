import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/product/product_repository.dart';
import 'package:k2ms_v2/models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitialState());

  Future<void> getProduct(String authToken, String categoryId) async {
    log('fetch products...');
    try {
      emit(ProductLoadingState());

      var response = await repository.getProduct(authToken, categoryId);
      log('response get product : $response');
      emit(ProductLoadedState(products: response));
    } catch (e) {
      log('error get product : $e');
      emit(ProductErrorState(message: e));
    }
  }
}
