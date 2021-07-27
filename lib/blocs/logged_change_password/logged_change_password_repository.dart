abstract class LCPasswordRepository {
  Future<String> changePassword(
      {String authToken, String oldPassword, String newPassword});
}
