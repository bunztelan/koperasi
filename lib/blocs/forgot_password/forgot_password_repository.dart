abstract class ForgotPasswordRepository {
  Future<String> sendCodeToEmail(String email);
}
