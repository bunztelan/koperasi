import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:k2ms_v2/models/user.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInRepository repository;

  SignInCubit(this.repository) : super(SignInInitialState());

  /// Login
  Future<void> login(String email, String password) async {
    emit(SignInLoadingState());

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    var token = await _firebaseMessaging.getToken();

    try {
      var response = await repository.login(email, password, token);

      // Add user data to local
      LocalData.setUserLocalData(response.user);

      // Add token data to local
      LocalData.setTokenLocalData(response.token);

      emit(SignInLoadedState(response.user));
    } catch (e) {
      emit(SignInErrorState(message: e.toString()));
    }
  }
}
