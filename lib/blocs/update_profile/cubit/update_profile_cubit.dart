import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/update_profile/update_profile_repository.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileRepository repository;

  UpdateProfileCubit(this.repository) : super(UpdateProfileInitialState());

  Future<void> updateProfile({
    String id,
    String authToken,
    String name,
    String maritalStatus,
    String email,
    String nip,
    String plantId,
  }) async {
    try {
      emit(UpdateProfileLoadingState());

      var response = await repository.updateProfile(
        id: id,
        authToken: authToken,
        name: name,
        maritalStatus: maritalStatus,
        email: email,
        nip: nip,
        plantId: plantId,
      );

      emit(UpdateProfileLoadedState(message: response));
    } catch (e) {
      emit(UpdateProfileErrorState(message: e));
    }
  }
}
