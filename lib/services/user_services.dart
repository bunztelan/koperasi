part of 'services.dart';

class UserServices {
  /// Get photo profile
  static Future<String> getAvatar(String authToken) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_user/profile',
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data']['avatar']['image_medium'];
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

        if (response.data['data']['profile']['avatar'] != null &&
            response.data['data']['profile']['avatar'].trim() != '') {
          String avatar = await getAvatar(token);
          user.setAvatar(avatar);
        }

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
        await Future.delayed(
          Duration(seconds: 2),
        ); // Make sure that data already created on DB

        // Send confirmation code
        await sendCodeRegToEmail(response.data['data']['user_id'].toString());

        return ApiReturnValue(
            value: response.data['data']['user_id'].toString(),
            message: 'Akun anda berhasil didaftarkan.');
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

  /// Send /  resend code to email (register)
  static Future<String> sendCodeRegToEmail(String userId) async {
    var dio = Dio();

    try {
      var response = await dio.get(
        '$host_auth/auth/resend-confirm-email/{$userId}',
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'Sukses';
      }
    } on DioError catch (_) {
      throw ('Kode konfirmasi gagal dikirim.');
    }
  }

  /// Confirm code email confirmation
  static Future<String> confirmEmailCode(String code) async {
    var dio = Dio();

    try {
      var response = await dio.post(
        '$host_auth/confirm_email',
        data: {'code': code},
        options: Options(
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'SUCCESS';
      } else {
        String errorMessage = somethingWentWrongMsg;

        if (response.data['message'] != null) {
          errorMessage = 'Kode tidak valid';
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

  /// Update photo on profile backend
  static Future<String> updateAvatarProfile(
      {String authToken, String id, String imageId, String email}) async {
    var dio = Dio();

    try {
      var response = await dio.put(
        '$host_user/$id',
        data: {'email': email, 'image_id': imageId},
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'Foto avatar berhasil diperbaruhi';
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

  /// Upload photo
  static Future<ApiReturnValue<String>> uploadPhoto(
      {String authToken, String filePath, String email, String userId}) async {
    var dio = Dio();

    try {
      var response = await dio.post(
        '$host_file/upload',
        data: FormData.fromMap({
          'type': 'image/png',
          'file': await MultipartFile.fromFile(
            filePath,
            filename: filePath,
            contentType: MediaType('image', 'png'),
          )
        }),
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Update avatar on profile
        await updateAvatarProfile(
          authToken: authToken,
          email: email,
          id: userId,
          imageId: response.data['id'].toString(),
        );

        return ApiReturnValue(
            value: response.data['path_url'],
            message: 'Foto anda berhasil diperbaruhi.');
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

  /// Change password
  static Future<String> changePassword(
      {String email, String password, String authToken}) async {
    var dio = Dio();

    try {
      var response = await dio.put(
        '$host_auth/reset_password',
        data: {
          'password': password,
          'token': authToken,
        },
        options: Options(
          headers: {"Authorization": 'Bearer $authToken'},
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );

      print(response.toString() + email.toString());

      if (response.statusCode == 200) {
        return 'Kata sandi anda berhasil diubah.';
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
