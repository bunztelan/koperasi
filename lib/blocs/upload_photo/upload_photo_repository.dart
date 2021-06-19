abstract class UploadPhotoRepository {
  Future<String> uploadPhoto({String authToken, String filePath});
}
