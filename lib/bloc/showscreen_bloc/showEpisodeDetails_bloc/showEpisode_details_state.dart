// episode_details_state.dart
import '../../../models/showscreen_modules/showEpisodeDetails_module.dart';

abstract class UserEpisodeDetailState {}

class UserEpisodeDetailInitial extends UserEpisodeDetailState {}

class UserEpisodeDetailLoading extends UserEpisodeDetailState {}

class UserEpisodeDetailLoaded extends UserEpisodeDetailState {
  final List<ShowEpisodeDetailsData> episodeDetails;
  final int showId;

  UserEpisodeDetailLoaded(this.episodeDetails, {required this.showId});
}

class UserEpisodeDetailError extends UserEpisodeDetailState {
  final String message;

  UserEpisodeDetailError(this.message);
}
