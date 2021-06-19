part of 'services.dart';

class UserServices {
  /// Login
  static Future<ApiReturnValue<SignInValue>> login(
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
        String token = response.data['data']['session']['access_token'];

        return ApiReturnValue(
            value: SignInValue(user: user, token: token), message: 'Sukses');
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
    } on DioError catch (_) {
      throw (somethingWentWrongMsg);
    }
  }

  /// Register
  static Future<ApiReturnValue<String>> register(
    String firebaseToken,
    String name,
    String email,
    String password,
    String nip,
    String plantId,
    String teamId,
    String phoneNumber,
    String maritalStatus,
    String address,
    String street,
    String latitude,
    String longitude,
    String roleId,
  ) async {
    var dio = Dio();

    try {
      var response = await dio.post(
        '$host_auth/register?platform=$platform',
        data: {
          'firebase_reg_id': firebaseToken,
          'name': name,
          'email': email,
          'password': password,
          'nip': nip,
          'plant_id': plantId,
          'team_id': teamId,
          'phone_number': phoneNumber,
          'marital_status': maritalStatus,
          'address': address,
          'street': street,
          'latitude': latitude,
          'longitude': longitude,
          'role_id': roleId
        },
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return ApiReturnValue(message: 'Akun anda berhasil didaftarkan.');
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          switch (response.data['message'].toString()) {
            case 'EMAIL_ALREADY_EXIST':
              errorMessage = 'Email anda sudah terdaftar.';
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
    } on DioError catch (_) {
      throw (somethingWentWrongMsg);
    }
  }

  /// Update profile
  static Future<ApiReturnValue<String>> updateProfile({
    String id,
    String authToken,
    String name,
    String maritalStatus,
    String email,
    String nip,
    String plantId,
  }) async {
    var dio = Dio();

    try {
      var response = await dio.put(
        '$host_user/$id',
        data: {
          'name': name,
          'email': email,
          'nip': nip,
          'plant_id': plantId,
          'marital_status': maritalStatus,
        },
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return ApiReturnValue(message: 'Akun anda berhasil didaftarkan.');
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          switch (response.data['message'].toString()) {
            case '[email must be an email]':
              errorMessage = 'Email anda tidak valid, mohon cek kembali.';
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

  /// Update address
  static Future<ApiReturnValue<String>> updateAddress({
    String authToken,
    String phoneNumber,
    String address,
    String street,
    String latitude,
    String longitude,
    String addressId,
  }) async {
    var dio = Dio();

    try {
      var response = await dio.put(
        '$host_address/$addressId',
        data: {
          'phone_number': phoneNumber,
          'address': address,
          'street': street,
          'latitude': latitude,
          'longitude': longitude
        },
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return ApiReturnValue(message: 'Alamat anda berhasil diperbaruhi.');
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          errorMessage = somethingWentWrongMsg;

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
