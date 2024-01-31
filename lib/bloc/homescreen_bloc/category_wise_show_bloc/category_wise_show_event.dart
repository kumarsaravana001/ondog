abstract class CategoryWiseShowEvent {}

class FetchCategoryWiseShows extends CategoryWiseShowEvent {
  final int categoryId;

  FetchCategoryWiseShows({required this.categoryId});
}
