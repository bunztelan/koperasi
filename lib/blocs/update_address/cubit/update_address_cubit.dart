import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/update_address/update_address_repository.dart';
import 'package:k2ms_v2/models/user.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UpdateAddressRepository repository;

  UpdateAddressCubit(this.repository) : super(UpdateAddressInitialState());

  Future<void> updateAddress({
    String authToken,
    String phoneNumber,
    String address,
    String street,
    String latitude,
    String longitude,
    String addressId,
    User oldUser,
  }) async {
    try {
      emit(UpdateAddressLoadingState());

      var response = await repository.updateAddress(
        authToken: authToken,
        phoneNumber: phoneNumber,
        address: address,
        street: street,
        latitude: latitude,
        longitude: longitude,
        addressId: addressId,
      );

      emit(UpdateAddressLoadedState(message: response));
    } catch (e) {
      emit(UpdateAddressErrorState(message: e));
    }
  }
}
