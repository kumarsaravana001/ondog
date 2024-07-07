import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ondgo_flutter/bloc/search_bloc/search_event.dart';
import 'package:ondgo_flutter/bloc/search_bloc/search_state.dart';
import 'package:http/http.dart' as http;
import '../../models/search_model/search_model.dart';
import '../../networkconfig/api_url.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoading());
      final categories = await fetchCategories(event.userId, event.query);
      emit(SearchLoaded(query: event.query, categories: categories));
    } catch (e) {
      emit(SearchError(message: e.toString(), query: event.query));
    }
  }
}

Future<List<SearchModelData>> fetchCategories(
    String userId, String query) async {
  String? userId = Hive.box('sessionBox').get('userId');

  final url = Uri.parse('https://ondgo.in/api/user-category-list.php');
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: json.encode({
        "user_id": userId,
        "query": query,
      }),
    );
    // print("userid ${userId} & query ${query}");
    // print("responce ${response.statusCode}");
    // print("responce ${response.body}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        List<dynamic> dataList = responseData['data'];
        List<SearchModelData> categories =
            dataList.map((item) => SearchModelData.fromJson(item)).toList();
        return categories;
      } else {
        throw Exception('Failed to fetch categories');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    rethrow;
  }
}
