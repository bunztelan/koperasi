import 'package:k2ms_v2/blocs/checkout/checkout_repository.dart';
import 'package:k2ms_v2/models/order.dart';
import 'package:k2ms_v2/services/services.dart';

class CheckoutRepositoryImp extends CheckoutRepository {
  @override
  Future<void> checkout({
    String authToken,
    List<Order> orders,
    String method,
    String note,
  }) async {
    try {
      await OrderServices.checkout(
        authToken: authToken,
        orders: orders,
        method: method,
        note: note,
      );
    } catch (e) {
      throw (e);
    }
  }
}
