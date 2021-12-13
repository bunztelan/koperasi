import 'package:k2ms_v2/blocs/confirmation_email_register/confirmation_email_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class CERegisterRepositoryImp extends CERegisterRepository {
  @override
  Future<String> confirmEmailCode(String code) async {
    try {
      String response = await UserServices.confirmEmailCode(code);

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
