import 'package:k2ms_v2/models/response/api_return_value.dart';

abstract class RegisterRepository {
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
  );
}
