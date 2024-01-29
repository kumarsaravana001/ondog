import 'package:ondgo_flutter/models/homescreen_model/category_list_model.dart';

abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  final List<CategoryListData> categories;

  CategoryListLoaded(this.categories);
}

class CategoryListError extends CategoryListState {
  final String message;

  CategoryListError(this.message);
}
