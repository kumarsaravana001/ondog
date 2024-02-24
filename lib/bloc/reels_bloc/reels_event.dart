abstract class ReelsEvent {}

class FetchReelsDetails extends ReelsEvent {
  final String userId;
  final int showId;
  final int episodeId;

  FetchReelsDetails({required this.userId, required this.showId, required this.episodeId});
}
