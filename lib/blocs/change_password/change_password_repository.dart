abstract class ChangePasswordRepository {
  Future<String> changePassword({
    String email,
    String password,
    String authToken,
  });
}
