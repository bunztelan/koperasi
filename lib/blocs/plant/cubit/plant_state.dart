part of 'plant_cubit.dart';

abstract class PlantState extends Equatable {
  const PlantState();

  @override
  List<Object> get props => [];
}

class PlantInitialState extends PlantState {}

class PlantLoadingState extends PlantState {}

class PlantErrorState extends PlantState {
  final String message;

  PlantErrorState({this.message});

  List<Object> get props => [message];
}

class PlantLoadedState extends PlantState {
  final List<Plant> plants;

  PlantLoadedState({this.plants});

  List<Object> get props => [plants];
}
