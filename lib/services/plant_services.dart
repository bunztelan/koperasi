part of 'services.dart';

class PlantServices {
  static Future<ApiReturnValue<List<Plant>>> getPlant() async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_plant/master',
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Plant> plants = [];

        if (response.data['data'] != null && response.data['data'].length > 0) {
          for (int i = 0; i < response.data['data'].length; i++) {
            plants.add(Plant.fromMap(response.data['data'][i]));
          }
        }

        return ApiReturnValue(value: plants, message: 'Sukses');
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
