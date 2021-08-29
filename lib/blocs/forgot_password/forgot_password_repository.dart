abstract class ForgotPasswordRepository {
  Future<String> sendCodeToEmail(String email);
  Future<String> resetForgotPassword({String password, String passwordToken});
}
