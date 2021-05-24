part of 'services.dart';


class UserServices{
  static Future<ApiReturnValue<User>> login(String email, String password,
      String firebaseToken,) async {
    await Future.delayed(Duration(milliseconds:500));

    return ApiReturnValue();
  }
}