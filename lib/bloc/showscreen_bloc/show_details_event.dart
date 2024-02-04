abstract class UserDetailEvent {}

class FetchUserDetail extends UserDetailEvent {
  // final String userId;
  final int showId;

  FetchUserDetail({
    // required this.userId,
    required this.showId,
  });
}
