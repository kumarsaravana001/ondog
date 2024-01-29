abstract class ShowEvent {}

class FetchShows extends ShowEvent {
  final String userId;
  final int categoryId;

  FetchShows(this.userId, this.categoryId);
}
