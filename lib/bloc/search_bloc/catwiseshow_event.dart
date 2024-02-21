abstract class CategoryWiseShowSearchEvent {}

class FetchCategoryWiseShowsSearch extends CategoryWiseShowSearchEvent {
  final String userId;
  final int categoryId;

  FetchCategoryWiseShowsSearch({required this.userId, required this.categoryId});
}
