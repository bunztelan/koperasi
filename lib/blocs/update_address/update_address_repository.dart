abstract class UpdateAddressRepository {
  Future<String> updateAddress({
    String authToken,
    String phoneNumber,
    String address,
    String street,
    String latitude,
    String longitude,
    String addressId,
  });
}
