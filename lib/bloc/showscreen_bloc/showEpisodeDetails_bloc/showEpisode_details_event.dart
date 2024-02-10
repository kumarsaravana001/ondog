// episode_details_event.dart
abstract class UserEpisodeDetailEvent {}

class FetchUserEpisodeDetail extends UserEpisodeDetailEvent {
  final int showId;

  FetchUserEpisodeDetail({required this.showId});
}
