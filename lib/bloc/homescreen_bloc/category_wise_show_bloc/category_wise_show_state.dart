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
abstract class CategoryWiseShow1State {}

class CategoryWiseShow1Initial extends CategoryWiseShow1State {}

class CategoryWiseShow1Loading extends CategoryWiseShow1State {}

class CategoryWiseShow1Loaded extends CategoryWiseShow1State {
  final List<CategoryWiseListData> shows;

  CategoryWiseShow1Loaded(this.shows);
}

class CategoryWiseShow1Error extends CategoryWiseShow1State {
  final String messages;

  CategoryWiseShow1Error(this.messages);
}

abstract class CategoryWiseShow2State {}

class CategoryWiseShow2Initial extends CategoryWiseShow2State {}

class CategoryWiseShow2Loading extends CategoryWiseShow2State {}

class CategoryWiseShow2Loaded extends CategoryWiseShow2State {
  final List<CategoryWiseListData> shows;

  CategoryWiseShow2Loaded(this.shows);
}

class CategoryWiseShow2Error extends CategoryWiseShow2State {
  final String messages;

  CategoryWiseShow2Error(this.messages);
}
