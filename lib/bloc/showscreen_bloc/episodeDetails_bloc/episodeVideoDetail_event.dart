abstract class VideoDetailsEvent {}

class FetchVideoDetails extends VideoDetailsEvent {
  final int showId;
  final int episodeId;

  FetchVideoDetails({required this.showId, required this.episodeId});
}
