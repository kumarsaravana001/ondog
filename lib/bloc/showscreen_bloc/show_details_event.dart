abstract class UserShowDetailEvent {}

class FetchUserShowDetail extends UserShowDetailEvent {
  FetchUserShowDetail({required this.showId});

  final int showId;
}
