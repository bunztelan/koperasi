import 'package:k2ms_v2/models/order.dart';

abstract class CheckoutRepository {
  Future<void> checkout({
    String authToken,
    List<Order> orders,
    String method,
    String note,
  });
}
