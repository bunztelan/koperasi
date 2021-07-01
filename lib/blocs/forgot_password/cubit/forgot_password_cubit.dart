import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/forgot_password/forgot_password_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordRepository repository;

  ForgotPasswordCubit(this.repository) : super(ForgotPasswordInitialState());

  Future<void> sendCodeToEmail(String email) async {
    try {
      emit(ForgotPasswordLoadingState());

      var response = await repository.sendCodeToEmail(email);

      emit(ForgotPasswordLoadedState(message: response));
    } catch (e) {
      emit(ForgotPasswordErrorState(message: e));
    }
  }
}
