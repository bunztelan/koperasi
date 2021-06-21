abstract class UploadPhotoRepository {
  Future<String> uploadPhoto(
      {String authToken, String filePath, String email, String userId});
}
