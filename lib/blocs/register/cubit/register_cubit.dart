import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:k2ms_v2/blocs/register/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepository repository;

  RegisterCubit(this.repository) : super(RegisterInitialState());

  Future<void> register(
    String name,
    String email,
    String password,
    String nip,
    String plantId,
    String teamId,
    String phoneNumber,
    String maritalStatus,
    String address,
    String street,
    String latitude,
    String longitude,
    String roleId,
  ) async {
    emit(RegisterLoadingState());

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    var token = await _firebaseMessaging.getToken();

    try {
      var response = await repository.register(
        token,
        name,
        email,
        password,
        nip,
        plantId,
        teamId,
        phoneNumber,
        maritalStatus,
        address,
        street,
        latitude,
        longitude,
        roleId,
      );
      emit(RegisterLoadedState(
        userId: response.value,
        message: response.message,
      ));
    } catch (e) {
      emit(RegisterErrorState(message: e));
    }
  }
}
