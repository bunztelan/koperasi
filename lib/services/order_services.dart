part of 'services.dart';

class OrderServices {
  /// Checkout
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

  /// Get order from server
  static Future<ApiReturnValue<List<OrderedItem>>> getOrderBackend(
      String authToken, String statusOrder) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_order/customer/$statusOrder',
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<OrderedItem> orders = [];
        // print(response.data['data']['items'][0]['items'][0]['product_name']);
        if (response.data['data']['items'] != null &&
            response.data['data']['items'].length > 0) {
          // List<dynamic> w = jsonEncode (response.data['data']['items'][0]['items'][0]['product_name']);

          for (int i = 0; i < response.data['data']['items'].length; i++) {
            /// Convert items to order
            List<Order> orderItems = [];

            for (int j = 0;
                j < response.data['data']['items'][i]['items'].length;
                j++) {
              orderItems.add(
                Order(
                    product: Product(
                      name: response.data['data']['items'][i]['items'][j]
                          ['product_name'],
                      price: response.data['data']['items'][i]['items'][j]
                          ['price'],
                    ),
                    qty: response.data['data']['items'][i]['items'][j]['qty']),
              );
            }

            orders.add(
              OrderedItem.fromMap(
                  response.data['data']['items'][i], orderItems),
            );
          }
        }

        return ApiReturnValue(value: orders, message: 'Sukses');
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
