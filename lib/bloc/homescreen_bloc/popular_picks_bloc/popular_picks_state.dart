import 'package:ondgo_flutter/models/homescreen_model/popular_picks_model.dart';

abstract class PopularPicksState {}

class PopularPicksInitial extends PopularPicksState {}

class PopularPicksLoading extends PopularPicksState {}

class PopularPicksLoaded extends PopularPicksState {
  final List<PopularpicksData> popularPicks;

  PopularPicksLoaded(this.popularPicks);
}

class PopularPicksError extends PopularPicksState {
  final String message;

  PopularPicksError(this.message);
}
