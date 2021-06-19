import 'package:k2ms_v2/blocs/upload_photo/upload_photo_repository.dart';
import 'package:k2ms_v2/services/services.dart';

class UploadPhotoRepositoryImp extends UploadPhotoRepository {
  @override
  Future<String> uploadPhoto({String authToken, String filePath}) async {
    try {
      var response = await UserServices.uploadPhoto(
          authToken: authToken, filePath: filePath);

      return response.value;
    } catch (e) {
      throw e;
    }
  }
}
