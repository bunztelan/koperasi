import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  Future<void> getUserLocalData() async {
    emit(UserLoadingState());

    try {
      User user = await LocalData.getUserLocalData();

      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserErrorState(message: 'Terjadi kesalahan'));
    }
  }

  Future<void> updateProfile({
    String name,
    String maritalStatus,
    String email,
    String nip,
    String plantId,
    User oldUser,
  }) async {
    try {
      User newUser = User(
        id: oldUser.id,
        name: name,
        email: email,
        maritalStatus: oldUser.maritalStatus,
        plantId: int.parse(plantId),
        nip: nip,
        address: oldUser.address,
        addressDesc: oldUser.addressDesc,
        addressId: oldUser.addressId,
        avatar: oldUser.avatar,
        createdAt: oldUser.createdAt,
        deletedAt: oldUser.deletedAt,
        emailConfirmToken: oldUser.emailConfirmToken,
        emailVerifiedAt: oldUser.emailVerifiedAt,
        forgotToken: oldUser.forgotToken,
        latitude: oldUser.latitude,
        longitude: oldUser.longitude,
        phoneNumber: oldUser.phoneNumber,
        role: oldUser.role,
        roleId: oldUser.roleId,
        status: oldUser.status,
        teamId: oldUser.teamId,
        updatedAt: oldUser.updatedAt,
      );

      LocalData.setUserLocalData(newUser);
      emit(UserLoadedState(newUser));
    } catch (e) {
      emit(UserErrorState(message: e));
    }
  }

  Future<void> updateAddress({
    String authToke,
    String address,
    String phoneNumber,
    String latitude,
    String longitude,
    String addressDesc,
  }) async {}

  Future<void> changePassword() async {}
  Future<void> updatePhoto() async {}
}
