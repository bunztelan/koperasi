import 'package:k2ms_v2/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProduct(String authToken, String categoryId);
}
