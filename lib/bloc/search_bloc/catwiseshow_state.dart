import '../../models/homescreen_model/category_list_wise_model.dart';

abstract class CategoryWiseShowSearchState {}

class CategoryWiseShowSearchInitial extends CategoryWiseShowSearchState {}

class CategoryWiseShowSearchLoading extends CategoryWiseShowSearchState {}

class CategoryWiseShowSearchLoaded extends CategoryWiseShowSearchState {
  final List<CategoryWiseListData> categoryWise;

  CategoryWiseShowSearchLoaded(this.categoryWise);
}

class CategoryWiseShowSearchError extends CategoryWiseShowSearchState {
  final String message;

  CategoryWiseShowSearchError(this.message);
}
