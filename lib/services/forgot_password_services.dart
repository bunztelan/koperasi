part of 'services.dart';

class ForgotPasswordServices {
  static Future<String> sendCodeToEmail(String email) async {
    var dio = Dio();

    try {
      var response = await dio.post(
        '$host_auth/forgot_password?platform=$platform',
        data: {'email': email},
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'SUKSES';
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          if (response.data['message'][0] != null &&
              response.data['message'][0] == 'email must be an email') {
            errorMessage = 'Email tidak valid.';
          } else {
            switch (response.data['message']) {
              case 'DATA_NOT_FOUND':
                errorMessage = 'Email anda belum terdaftar.';
                break;
              case 'email must be an email':
                errorMessage = 'Email tidak valid.';
                break;
              default:
                errorMessage = somethingWentWrongMsg;
                break;
            }
          }
          throw (errorMessage);
        } else {
          throw (somethingWentWrongMsg);
        }
      }
    } on DioError catch (_) {
      throw (somethingWentWrongMsg);
    }
  }

  static Future<String> resetForgotPassword(
      {String password, String passwordToken}) async {
    var dio = Dio();

    try {
      var response = await dio.put(
        '$host_auth/reset_password',
        data: {'password': password, 'token': passwordToken},
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'SUKSES';
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          switch (response.data['message']) {
            case 'INVALID_TOKEN_PASSWORD':
              errorMessage = 'Kode yang anda masukkan salah.';
              break;
            default:
              errorMessage = somethingWentWrongMsg;
              break;
          }

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
