abstract class SearchEvent {}

class FetchCategories extends SearchEvent {
  final String userId;
  final String query;

  FetchCategories({required this.userId, required this.query});
}

