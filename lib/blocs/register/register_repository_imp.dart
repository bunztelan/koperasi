import 'package:k2ms_v2/services/services.dart';

import 'register_repository.dart';
import '../../models/response/api_return_value.dart';

class RegisterRepositoryImp extends RegisterRepository {
  @override
  Future<ApiReturnValue> register(
    String firebaseToken,
    String name,
    String email,
    String password,
    String nip,
    String plantId,
    String teamId,
    String phoneNumber,
    String maritalStatus,
    String address,
    String street,
    String latitude,
    String longitude,
    String roleId,
  ) async {
    try {
      var response = UserServices.register(
        firebaseToken,
        name,
        email,
        password,
        nip,
        plantId,
        teamId,
        phoneNumber,
        maritalStatus,
        address,
        street,
        latitude,
        longitude,
        roleId,
      );

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
