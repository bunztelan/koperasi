part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<List<Product>>> getCategory(
      String authToken, String categoryId) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_product/$categoryId/mobile',
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Product> products = [];

        if (response.data['data']['products']['items'] != null &&
            response.data['data']['products']['items'].length > 0) {
          for (int i = 0;
              i < response.data['data']['products']['items'].length;
              i++) {
            products.add(
              Product.fromMap(response.data['data']['products']['items'][i]),
            );
          }
        }

        return ApiReturnValue(value: products, message: 'Sukses');
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
