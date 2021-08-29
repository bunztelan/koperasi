part of 'services.dart';

class CategoryServices {
  static Future<ApiReturnValue<List<Category>>> getCategory(
      String authToken) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_product/0/mobile',
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Category> categories = [];

        if (response.data['data']['categories'] != null &&
            response.data['data']['categories'].length > 0) {
          for (int i = 0; i < response.data['data']['categories'].length; i++) {
            categories
                .add(Category.fromMap(response.data['data']['categories'][i]));
          }
        }

        return ApiReturnValue(value: categories, message: 'Sukses');
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          throw (errorMessage);
        } else {
          throw (somethingWentWrongMsg);
        }
      }
    } on DioError catch (_) {
      throw (somethingWentWrongMsg);
    }
  }
}
