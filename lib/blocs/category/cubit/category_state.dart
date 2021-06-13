part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState({this.message});

  List<Object> get props => [message];
}

class CategoryLoadedState extends CategoryState {
  final List<Category> categories;

  CategoryLoadedState({this.categories});

  List<Object> get props => [categories];
}
