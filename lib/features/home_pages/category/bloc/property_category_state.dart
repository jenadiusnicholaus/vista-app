part of 'property_category_bloc.dart';

@immutable
sealed class PropertyCategoryState {}

final class PropertyCategoryInitial extends PropertyCategoryState {}

final class PropertyCategoryLoading extends PropertyCategoryState {}

final class PropertyCategoryLoaded extends PropertyCategoryState {
  final PropertyCategoriesModel propertyCategoryList;

  PropertyCategoryLoaded({required this.propertyCategoryList});
}

final class PropertyCategoryError extends PropertyCategoryState {
  final String error;

  PropertyCategoryError({required this.error});
}
