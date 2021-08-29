import 'package:k2ms_v2/blocs/category/category_repository.dart';
import 'package:k2ms_v2/models/category.dart';
import 'package:k2ms_v2/services/services.dart';

class CategoryRepositoryImp extends CategoryRepository {
  @override
  Future<List<Category>> getCategory(String authToken) async {
    try {
      var response = await CategoryServices.getCategory(authToken);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
