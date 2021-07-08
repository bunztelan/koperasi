import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/change_password/change_password_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordRepository repository;

  ChangePasswordCubit(this.repository) : super(ChangePasswordInitialState());

  Future<void> changePassword({
    String email,
    String password,
    String authToken,
  }) async {
    try {
      emit(ChangePasswordLoadingState());
      var response = await repository.changePassword(
        email: email,
        password: password,
        authToken: authToken,
      );
      emit(ChangePasswordLoadedState(message: response));
    } catch (e) {
      emit(ChangePasswordErrorState(message: e));
    }
  }
}
