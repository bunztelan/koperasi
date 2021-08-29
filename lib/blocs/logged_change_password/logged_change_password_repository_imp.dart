import 'package:k2ms_v2/blocs/logged_change_password/logged_change_password_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class LCPasswordRepositoryImp extends LCPasswordRepository {
  @override
  Future<String> changePassword(
      {String authToken, String oldPassword, String newPassword}) async {
    try {
      var response = await UserServices.loggedChangePassword(
        authToken: authToken,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return response;
    } catch (e) {
      throw (e);
    }
  }
}
