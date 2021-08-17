import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/banner/banner_repository.dart';
import 'package:k2ms_v2/models/banner.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerRepository repository;

  BannerCubit(this.repository) : super(BannerInitialState());

  Future<void> getBanner(String authToken) async {
    try {
      emit(BannerLoadingState());

      var response = await repository.getBanner(authToken);

      if (response.length < 1) {
        List<BannerModel> convertResponse = [];
        response = convertResponse;
      }

      emit(BannerLoadedState(banners: response));
    } catch (e) {
      print(e.toString());
      emit(BannerErrorState(message: e));
    }
  }
}
