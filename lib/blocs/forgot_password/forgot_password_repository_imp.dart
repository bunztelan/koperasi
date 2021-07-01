import 'package:k2ms_v2/services/services.dart';

import 'forgot_password_repository.dart';

class ForgotPasswordRepositoryImp extends ForgotPasswordRepository {
  @override
  Future<String> sendCodeToEmail(String email) async {
    try {
      var response = await ForgotPasswordServices.sendCodeToEmail(email);

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
