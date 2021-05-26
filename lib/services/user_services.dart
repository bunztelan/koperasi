part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> login(
    String email,
    String password,
    String firebaseToken,
  ) async {
    var dio = Dio();
    try {
      var response = await dio.post(
        '$host_auth/login?platform=$platform',
        data: {
          'email': email,
          'password': password,
          'firebase_reg_id': firebaseToken,
        },
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(response.data['data']['profile']);
        return ApiReturnValue(value: user, message: 'Sukses');
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          switch (response.data['message'].toString()) {
            case '[email must be an email]':
              errorMessage = 'Email anda tidak valid, mohon cek kembali.';
              break;
            case 'DATA_NOT_FOUND':
              errorMessage = 'Email anda tidak/belum terdaftar.';
              break;
            case 'INVALID_PASSWORD':
              errorMessage = 'Kata sandi anda salah, mohon cek kembali.';
              break;
            case 'CONFIRM_YOUR_EMAIL':
              errorMessage = 'Email anda belum terkonfirmasi.';
              break;
            default:
              errorMessage = response.data['message'].toString();
              break;
          }

          throw (errorMessage);
        } else {
          throw (somethingWentWrongMsg);
        }
      }
    } on DioError catch (e) {
      throw (somethingWentWrongMsg);
    }
  }
}
