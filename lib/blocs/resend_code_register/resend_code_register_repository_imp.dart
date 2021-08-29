import 'package:k2ms_v2/blocs/resend_code_register/resend_code_register_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class ResendCodeRegisterRepositoryImp extends ResendCodeRegisterRepository {
  @override
  Future<String> resendCodeRegister(String userId) async {
    try {
      var response = await UserServices.sendCodeRegToEmail(userId);
      return response;
    } catch (e) {
      throw (e);
    }
  }
}
