import 'package:ondgo_flutter/models/homescreen_model/category_list_model.dart';

import '../../../../models/homescreen_model/banner_model.dart';

abstract class HomeScreenBannerState {}

class HomeScreenBannerInitial extends HomeScreenBannerState {}

class HomeScreenBannerLoading extends HomeScreenBannerState {
  
}

class HomeScreenBannerLoaded extends HomeScreenBannerState {
  final List<Data> banners;

  HomeScreenBannerLoaded(this.banners);
}

class HomeScreenBannerError extends HomeScreenBannerState {
  final String message;

  HomeScreenBannerError(this.message);
}
