import '../../models/user.dart';

abstract class SignInRepository {
  Future<User> login(
    String email,
    String password,
    String firebaseToken,
  );
}
