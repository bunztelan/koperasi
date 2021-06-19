part of 'update_address_cubit.dart';

abstract class UpdateAddressState extends Equatable {
  const UpdateAddressState();

  @override
  List<Object> get props => [];
}

class UpdateAddressInitialState extends UpdateAddressState {}

class UpdateAddressLoadingState extends UpdateAddressState {}

class UpdateAddressErrorState extends UpdateAddressState {
  final String message;
  UpdateAddressErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class UpdateAddressLoadedState extends UpdateAddressState {
  final String message;
  UpdateAddressLoadedState({this.message});

  @override
  List<Object> get props => [message];
}
