part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitialState extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final String message;
  UpdateProfileErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class UpdateProfileLoadedState extends UpdateProfileState {
  final String message;
  UpdateProfileLoadedState({this.message});

  @override
  List<Object> get props => [message];
}
