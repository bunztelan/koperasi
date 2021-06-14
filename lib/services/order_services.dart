part of 'services.dart';

class OrderServices {
  static Future<ApiReturnValue<String>> checkout({
    String authToken,
    List<Order> orders,
    String method,
    String note,
  }) async {
    var dio = Dio();

    List<Map<String, dynamic>> convertOrder =
        orders.map((e) => {'product_id': e.product.id, 'qty': e.qty}).toList();

    try {
      var response = await dio.post(
        '$host_order/create',
        data: {
          'items': convertOrder,
          'method': method,
          'note': note,
        },
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return ApiReturnValue(value: 'Sukses', message: 'Sukses');
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
