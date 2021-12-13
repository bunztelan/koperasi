import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/sign_in/sign_in_local.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(TokenInitialState());

  Future<void> getTokenLocalData() async {
    try {
      emit(TokenLoadingState());

      String token = await LocalData.getTokenLocalData();

      emit(TokenLoadedState(token: token));
    } catch (e) {
      emit(TokenErrorState(message: 'Terjadi kesalahan'));
    }
  }
}
