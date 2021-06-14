import 'package:k2ms_v2/models/sign_in_value.dart';

import '../../models/user.dart';

abstract class SignInRepository {
  Future<SignInValue> login(
    String email,
    String password,
    String firebaseToken,
  );
}
