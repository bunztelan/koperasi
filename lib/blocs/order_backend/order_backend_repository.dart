import 'package:k2ms_v2/models/ordered_item.dart';

abstract class OrderBackendRepository {
  Future<List<OrderedItem>> getOrderBackend(
      String authToken, String statusOrder);
}
