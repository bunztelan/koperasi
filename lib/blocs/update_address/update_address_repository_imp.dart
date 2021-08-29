import 'package:k2ms_v2/blocs/update_address/update_address_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class UpdateAddressRepositoryImp extends UpdateAddressRepository {
  @override
  Future<String> updateAddress({
    String authToken,
    String phoneNumber,
    String address,
    String street,
    String latitude,
    String longitude,
    String addressId,
  }) async {
    try {
      var response = await UserServices.updateAddress(
          authToken: authToken,
          phoneNumber: phoneNumber,
          address: address,
          street: street,
          latitude: latitude,
          longitude: longitude,
          addressId: addressId);

      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
