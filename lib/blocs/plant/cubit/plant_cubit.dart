import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/plant/plant_repository.dart';
import 'package:k2ms_v2/models/plant.dart';

part 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  PlantRepository repository;

  PlantCubit(this.repository) : super(PlantInitialState());

  Future<void> getPlant() async {
    try {
      emit(PlantLoadingState());

      var response = await repository.getPlant();

      print(response.length);

      emit(PlantLoadedState(plants: response));
    } catch (e) {
      emit(PlantErrorState(message: e));
    }
  }
}
