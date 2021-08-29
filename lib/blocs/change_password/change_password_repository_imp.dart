import 'package:k2ms_v2/blocs/change_password/change_password_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class ChangePasswordRepositoryImp extends ChangePasswordRepository {
  @override
  Future<String> changePassword({
    String email,
    String password,
    String authToken,
  }) async {
    try {
      var response = await UserServices.changePassword(
        email: email,
        password: password,
        authToken: authToken,
      );

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
