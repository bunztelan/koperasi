import 'package:k2ms_v2/blocs/product/product_repository.dart';
import 'package:k2ms_v2/models/product.dart';
import 'package:k2ms_v2/services/services.dart';

class ProductRepositoryImp extends ProductRepository {
  @override
  Future<List<Product>> getProduct(String authToken, String categoryId) async {
    try {
      var response = await ProductServices.getCategory(authToken, categoryId);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
