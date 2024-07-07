// Located in video_details_state.dart
import 'package:ondgo_flutter/models/showscreen_modules/episodeDetail_module.dart';

abstract class VideoDetailsState {}

class VideoDetailsInitial extends VideoDetailsState {}

class VideoDetailsLoading extends VideoDetailsState {}

class VideoDetailsLoaded extends VideoDetailsState {
  final List<EpisodeDetailData> episodevideoDetails;
  final int showId;
  final int episodeId;

  VideoDetailsLoaded(this.episodevideoDetails,
      {required this.showId, required this.episodeId});
}

class VideoDetailsError extends VideoDetailsState {
  final String message;

  VideoDetailsError(this.message);
}
