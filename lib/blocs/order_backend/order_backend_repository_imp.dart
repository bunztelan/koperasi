import 'package:k2ms_v2/blocs/order_backend/order_backend_repository.dart';
import 'package:k2ms_v2/models/ordered_item.dart';
import 'package:k2ms_v2/services/services.dart';

class OrderBackendRepositoryImp extends OrderBackendRepository {
  @override
  Future<List<OrderedItem>> getOrderBackend(
      String authToken, String statusOrder) async {
    try {
      var response =
          await OrderServices.getOrderBackend(authToken, statusOrder);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
