import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/logged_change_password/logged_change_password_repository.dart';

part 'logged_change_password_state.dart';

class LCPasswordCubit extends Cubit<LCPasswordState> {
  LCPasswordRepository repository;

  LCPasswordCubit(this.repository) : super(LCPasswordInitialState());

  Future<void> changePassword({
    String authToken,
    String oldPassword,
    String newPassword,
  }) async {
    try {
      emit(LCPasswordLoadingState());

      var response = await repository.changePassword(
        authToken: authToken,
        newPassword: newPassword,
        oldPassword: oldPassword,
      );

      emit(LCPasswordLoadedState(message: response));
    } catch (e) {
      emit(LCPasswordErrorState(message: e.toString()));
    }
  }
}
