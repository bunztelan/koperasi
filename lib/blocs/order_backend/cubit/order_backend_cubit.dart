import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/order_backend/order_backend_repository.dart';
import 'package:k2ms_v2/models/ordered_item.dart';

part 'order_backend_state.dart';

class OrderBackendCubit extends Cubit<OrderBackendState> {
  List<OrderedItem> orders = [];

  OrderBackendRepository repository;

  OrderBackendCubit(this.repository) : super(OrderBackendInitialState());

  /// Get order from server
  Future<void> getOrderBackend(String authToken, String statusOrder) async {
    try {
      emit(OrderBackendLoadingState());

      var response = await repository.getOrderBackend(authToken, statusOrder);

      orders = response;

      emit(OrderBackendLoadedState(orders: orders));
    } catch (e) {
      emit(OrderBackendErrorState(message: e.toString()));
    }
  }
}
