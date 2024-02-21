import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/search_bloc/catwiseshow_event.dart';
import 'package:ondgo_flutter/bloc/search_bloc/catwiseshow_state.dart';
import '../../models/homescreen_model/category_list_wise_model.dart';
import '../../networkconfig/api_url.dart';

class CategoryWiseShowSearchBloc
    extends Bloc<CategoryWiseShowSearchEvent, CategoryWiseShowSearchState> {
  CategoryWiseShowSearchBloc() : super(CategoryWiseShowSearchInitial()) {
    on<FetchCategoryWiseShowsSearch>(_onFetchCategoryWiseShows);
  }

  Future<void> _onFetchCategoryWiseShows(
    FetchCategoryWiseShowsSearch event,
    Emitter<CategoryWiseShowSearchState> emit,
  ) async {
    emit(CategoryWiseShowSearchLoading());
    try {
      final shows = await _fetchCategoryWiseShows(event.categoryId);
      emit(CategoryWiseShowSearchLoaded(shows));
    } catch (e) {
      emit(CategoryWiseShowSearchError(e.toString()));
    }
  }

  Future<List<CategoryWiseListData>> _fetchCategoryWiseShows(
      int categoryId) async {
    String? userId = Hive.box('sessionBox').get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');

    final body = json.encode({
      'user_id': userId,
      'category_id': categoryId,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        List<dynamic> dataList = responseData['data'];
        return dataList
            .map((item) => CategoryWiseListData.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch category wise shows');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
