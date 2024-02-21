import 'package:ondgo_flutter/models/search_model/search_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final String query;
  final List<SearchModelData> categories;

  SearchLoaded({required this.query, required this.categories});
}

class SearchError extends SearchState {
  final String message;
  final String query;

  SearchError({required this.message, this.query = ''});
}
