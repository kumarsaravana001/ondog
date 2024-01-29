import 'package:ondgo_flutter/models/homescreen_model/category_list_wise_model.dart';

abstract class CategoryWiseShowState {}

class CategoryWiseShowInitial extends CategoryWiseShowState {}

class CategoryWiseShowLoading extends CategoryWiseShowState {}

class CategoryWiseShowLoaded extends CategoryWiseShowState {
  final List<CategoryWiseListData> shows;

  CategoryWiseShowLoaded(this.shows);
}

class CategoryWiseShowError extends CategoryWiseShowState {
  final String message;

  CategoryWiseShowError(this.message);
}
