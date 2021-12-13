part of 'services.dart';

class BannerServices {
  static Future<ApiReturnValue<List<BannerModel>>> getBanner(
      String authToken) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_banner',
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<BannerModel> banners = [];

        if (response.data['data']['items'] != null &&
            response.data['data']['items'].length > 0) {
          for (int i = 0; i < response.data['data']['items'].length; i++) {
            banners.add(BannerModel.fromMap(response.data['data']['items'][i]));
          }
        }

        return ApiReturnValue(value: banners, message: 'Sukses');
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
