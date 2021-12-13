import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k2ms_v2/blocs/category/category_repository.dart';
import 'package:k2ms_v2/models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository repository;

  CategoryCubit(this.repository) : super(CategoryInitialState());

  Future<void> getCategory(String authToken) async {
    try {
      emit(CategoryLoadingState());
      var response = await repository.getCategory(authToken);

      emit(CategoryLoadedState(categories: response));
    } catch (e) {
      emit(CategoryErrorState(message: e));
    }
  }
}
