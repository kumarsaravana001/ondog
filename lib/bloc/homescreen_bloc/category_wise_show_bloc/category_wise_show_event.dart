abstract class CategoryWiseShowEvent {}

class FetchCategoryWiseShows extends CategoryWiseShowEvent {
  final int categoryId;

  FetchCategoryWiseShows({required this.categoryId});
}

abstract class CategoryWiseShow1Event {}

class FetchCategoryWiseShows1 extends CategoryWiseShow1Event {
  final int categoryIdd;

  FetchCategoryWiseShows1({required this.categoryIdd});
}


abstract class CategoryWiseShow2Event {}

class FetchCategoryWiseShows2 extends CategoryWiseShow2Event {
  final int categoryIddd;

  FetchCategoryWiseShows2({required this.categoryIddd});
}
