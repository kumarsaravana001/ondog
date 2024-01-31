import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/models/homescreen_model/category_list_wise_model.dart';

class CategoryWiseShowBloc
    extends Bloc<CategoryWiseShowEvent, CategoryWiseShowState> {
  CategoryWiseShowBloc() : super(CategoryWiseShowInitial()) {
    on<FetchCategoryWiseShows>(_onFetchCategoryWiseShows);
  }

  int categoryId = 3;

  Future<List<CategoryWiseListData>> fetchShows() async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');

    final body = json.encode({
      'user_id': userId,
      'category_id': categoryId,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API_KEY':
              'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          List<dynamic> dataList = responseData['data'];
          List<CategoryWiseListData> shows = dataList
              .map((item) => CategoryWiseListData.fromJson(item))
              .toList();

          return shows;
        } else {
          throw Exception('Failed to fetch shows');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onFetchCategoryWiseShows(
      FetchCategoryWiseShows event, Emitter<CategoryWiseShowState> emit) async {
    try {
      emit(CategoryWiseShowLoading());
      final shows = await fetchShows();
      emit(CategoryWiseShowLoaded(shows));
    } catch (e) {
      emit(CategoryWiseShowError(e.toString()));
    }
  }
}
