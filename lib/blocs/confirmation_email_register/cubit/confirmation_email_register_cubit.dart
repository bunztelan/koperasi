import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/confirmation_email_register/confirmation_email_repository.dart';

part 'confirmation_email_register_state.dart';

class CERegisterCubit extends Cubit<CERegisterState> {
  CERegisterRepository repository;

  CERegisterCubit(this.repository) : super(CERegisterInitialState());

  Future<void> initState() async {
    emit(CERegisterInitialState());
  }

  Future<void> confirmEmailCode(String code) async {
    try {
      emit(CERegisterLoadingState());

      var response = await repository.confirmEmailCode(code);

      emit(CERegisterLoadedState(message: response));
    } catch (e) {
      emit(CERegisterErrorState(message: e));
    }
  }
}
