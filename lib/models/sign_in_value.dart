import 'package:k2ms_v2/models/user.dart';

class SignInValue {
  User user;
  String token;

  SignInValue({
    this.user,
    this.token = '',
  });
}
