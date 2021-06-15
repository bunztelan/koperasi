import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/models/product.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<Order> orders = [];

  OrderCubit() : super(OrderInitialState());

  /// Initial data (from local data)
  Future<void> initialData(List<Order> initOrders) async {
    emit(OrderLoadingState());

    orders = initOrders;

    emit(OrderLoadedState(orders: orders));
  }

  int searchOrderProduct(int searchId) {
    if (orders.length == 0 || orders == null) return -1;

    List<Order> isProductThere =
        orders.where((e) => e.product.id == searchId).toList();

    if (isProductThere == null || isProductThere.length == 0) {
      return -1;
    }

    return orders.indexOf(isProductThere[0]);
  }

  int setOrderQty(Product product) {
    if (orders.length == 0 || orders == null) return 1;

    if (searchOrderProduct(product.id) != -1) {
      return orders[searchOrderProduct(product.id)].qty;
    }

    return 1;
  }

  Future<void> setOrder(Product product, int qty) async {
    int indexOfOrder = searchOrderProduct(product.id);

    if (orders.length < 1 || orders == null) {
      orders.insert(0, Order(product: product, qty: qty));
    } else {
      if (indexOfOrder != -1) {
        orders[indexOfOrder] = Order(product: product, qty: qty);
      } else {
        orders.insert(0, Order(product: product, qty: qty));
      }
    }

    LocalData.setCartLocalData(orders);
  }

  /// Remove item from cart
  Future<void> removeItem(int searchId) async {
    emit(OrderLoadingState());

    orders.removeAt(searchOrderProduct(searchId));

    LocalData.setCartLocalData(orders);

    emit(OrderLoadedState(orders: orders));
  }

  /// Get order from cart
  Future<void> getOrder() async {
    try {
      emit(OrderLoadedState(orders: orders));
    } catch (e) {
      emit(OrderErrorState(message: 'Terjadi kesalahan.'));
    }
  }
}
