import 'package:k2ms_v2/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategory(String authToken);
}
