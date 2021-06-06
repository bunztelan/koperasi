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
}
