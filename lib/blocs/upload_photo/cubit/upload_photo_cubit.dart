import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/upload_photo/upload_photo_repository.dart';

part 'upload_photo_state.dart';

class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  UploadPhotoRepository repository;

  UploadPhotoCubit(this.repository) : super(UploadPhotoInitial());

  Future<void> uploadPhoto(String authToken, String filePath) async {
    try {
      emit(UploadPhotoLoadingState());

      var response = await repository.uploadPhoto(
          authToken: authToken, filePath: filePath);

      emit(UploadPhotoLoadedState(path: response));
    } catch (e) {
      print('ERROR IS' + e.toString());

      emit(UploadPhotoErrorState(message: e));
    }
  }
}
