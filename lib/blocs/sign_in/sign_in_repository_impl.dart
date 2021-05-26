import 'package:k2ms_v2/models/user.dart';
import 'package:k2ms_v2/services/services.dart';
import 'sign_in_repository.dart';

class SignInRepositoryImp extends SignInRepository {
  @override
  Future<User> login(
      String email, String password, String firebaseToken) async {
    try {
      var response = await UserServices.login(email, password, firebaseToken);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
