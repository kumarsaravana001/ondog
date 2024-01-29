import 'package:ondgo_flutter/models/homescreen_model/category_list_wise_model.dart';

abstract class ShowState {}

class ShowInitial extends ShowState {}

class ShowLoading extends ShowState {}

class ShowLoaded extends ShowState {
  final List<CategoryWiseListData> shows;

  ShowLoaded(this.shows);
}

class ShowError extends ShowState {
  final String message;

  ShowError(this.message);
}
