import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/checkout/checkout_repository.dart';
import 'package:k2ms_v2/models/order.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutRepository repository;

  CheckoutCubit(this.repository) : super(CheckoutInitialState());

  Future<void> checkout({
    String authToken,
    List<Order> orders,
    String method,
    String note,
  }) async {
    try {
      emit(CheckoutLoadingState());

      await repository.checkout(
        authToken: authToken,
        orders: orders,
        method: method,
        note: note,
      );

      emit(CheckoutLoadedState());
    } catch (e) {
      emit(CheckkoutErrorState(message: 'Terjadi kesalahan.'));
    }
  }
}
