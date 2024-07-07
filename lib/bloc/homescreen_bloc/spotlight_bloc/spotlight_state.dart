import '../../../models/homescreen_model/spotlight_module.dart';

abstract class HomeScreenSpotlightState {}

class HomeScreenSpotlightInitial extends HomeScreenSpotlightState {}

class HomeScreenSpotlightLoading extends HomeScreenSpotlightState {}

class HomeScreenSpotlightLoaded extends HomeScreenSpotlightState {
  final List<SpotLightModelData> spotlight;

  HomeScreenSpotlightLoaded(this.spotlight);
}

class HomeScreenSpotlightError extends HomeScreenSpotlightState {
  final String message;

  HomeScreenSpotlightError(this.message);
}
