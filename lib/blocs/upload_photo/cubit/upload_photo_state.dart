part of 'upload_photo_cubit.dart';

abstract class UploadPhotoState extends Equatable {
  const UploadPhotoState();

  @override
  List<Object> get props => [];
}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoadingState extends UploadPhotoState {}

class UploadPhotoErrorState extends UploadPhotoState {
  final String message;
  UploadPhotoErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class UploadPhotoLoadedState extends UploadPhotoState {
  final String path;
  UploadPhotoLoadedState({this.path});

  @override
  List<Object> get props => [path];
}
