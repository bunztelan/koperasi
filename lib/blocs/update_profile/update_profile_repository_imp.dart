import 'package:k2ms_v2/blocs/update_profile/cubit/update_profile_cubit.dart';
import 'package:k2ms_v2/blocs/update_profile/update_profile_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class UpdateProfileRepositoryImp extends UpdateProfileRepository {
  @override
  Future<String> updateProfile({
    String id,
    String authToken,
    String name,
    String maritalStatus,
    String email,
    String nip,
    String plantId,
  }) async {
    try {
      var response = await UserServices.updateProfile(
        authToken: authToken,
        email: email,
        id: id,
        maritalStatus: maritalStatus,
        name: name,
        nip: nip,
        plantId: plantId,
      );
      return response.value;
    } catch (e) {
      throw (e);
    }
  }
}
