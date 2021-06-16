abstract class UpdateProfileRepository {
  Future<String> updateProfile({
    String id,
    String authToken,
    String name,
    String maritalStatus,
    String email,
    String nip,
    String plantId,
  });
}
