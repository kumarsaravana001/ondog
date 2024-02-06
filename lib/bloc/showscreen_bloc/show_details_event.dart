abstract class UserShowDetailEvent {}

class FetchUserShowDetail extends UserShowDetailEvent {
  // final String userId;
  final int showId;

  FetchUserShowDetail({
    // required this.userId,
    required this.showId,
  });
}
