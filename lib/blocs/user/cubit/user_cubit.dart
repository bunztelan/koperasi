import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  /// Get local data user
  Future<void> getUserLocalData() async {
    emit(UserLoadingState());

    try {
      User user = await LocalData.getUserLocalData();

      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserErrorState(message: 'Terjadi kesalahan'));
    }
  }

  /// Update local profile and BLOC
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

  /// Update local address and BLOC
  Future<void> updateAddress({
    String address,
    String phoneNumber,
    String latitude,
    String longitude,
    String addressDesc,
    User oldUser,
  }) async {
    try {
      User newUser = User(
        address: address,
        addressDesc: addressDesc,
        phoneNumber: phoneNumber,
        latitude: double.parse(latitude),
        longitude: double.parse(longitude),
        id: oldUser.id,
        name: oldUser.name,
        email: oldUser.email,
        maritalStatus: oldUser.maritalStatus,
        plantId: oldUser.plantId,
        nip: oldUser.nip,
        addressId: oldUser.addressId,
        avatar: oldUser.avatar,
        createdAt: oldUser.createdAt,
        deletedAt: oldUser.deletedAt,
        emailConfirmToken: oldUser.emailConfirmToken,
        emailVerifiedAt: oldUser.emailVerifiedAt,
        forgotToken: oldUser.forgotToken,
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

  Future<void> updatePhoto(String avatar, User oldUser) async {
    try {
      User newUser = User(
        avatar: avatar,
        address: oldUser.address,
        addressDesc: oldUser.addressDesc,
        phoneNumber: oldUser.phoneNumber,
        latitude: oldUser.latitude,
        longitude: oldUser.longitude,
        id: oldUser.id,
        name: oldUser.name,
        email: oldUser.email,
        maritalStatus: oldUser.maritalStatus,
        plantId: oldUser.plantId,
        nip: oldUser.nip,
        addressId: oldUser.addressId,
        createdAt: oldUser.createdAt,
        deletedAt: oldUser.deletedAt,
        emailConfirmToken: oldUser.emailConfirmToken,
        emailVerifiedAt: oldUser.emailVerifiedAt,
        forgotToken: oldUser.forgotToken,
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

  Future<void> changePassword() async {}
}
