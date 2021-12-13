import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/resend_code_register/resend_code_register_repository.dart';

part 'resend_code_register_state.dart';

class ResendCodeRegisterCubit extends Cubit<ResendCodeRegisterState> {
  ResendCodeRegisterRepository repository;

  ResendCodeRegisterCubit(this.repository)
      : super(ResendCodeRegisterInitialState());

  Future<void> resendCodeRegister(String userId) async {
    try {
      emit(ResendCodeRegisterLoadingState());

      var response = await repository.resendCodeRegister(userId);

      emit(ResendCodeRegisterLoadedState(message: 'Kode berhasil dikirim.'));
    } catch (e) {
      emit(ResendCodeRegisterErrorState(message: e));
    }
  }
}
