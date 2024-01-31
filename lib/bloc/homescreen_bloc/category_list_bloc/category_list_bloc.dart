import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_state.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/models/homescreen_model/category_list_model.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListInitial()) {
    on<FetchCategoryList>(_onFetchCategoryList);
  }

  // final LoginBloc loginBloc;

  Future<List<CategoryListData>> fetchCategoryList() async {
    // String? userId = loginBloc.userId;
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-home-category-list.php');

    if (userId == null) {
      throw Exception('User ID is null');
    }

    final body = json.encode({
      'user_id': userId,
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

      // print('Category List Response Status: ${response.statusCode}');
      // print('Category List Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['status'] == true) {
          List<CategoryListData> categories = [];
          responseData['data'].forEach((item) {
            var dataCat = CategoryListData.fromJson(item);
            // print('Datacar Print +++ ${dataCat.toJson()}');
            categories.add(dataCat);
          });

          return categories;
        } else {
          throw Exception('Failed to fetch category list');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onFetchCategoryList(
      CategoryListEvent event, Emitter<CategoryListState> emit) async {
    try {
      emit(CategoryListLoading());
      final categories = await fetchCategoryList();
      emit(CategoryListLoaded(categories));
      // print("Category --- ${categories}");
    } catch (e) {
      // print("catch ${e.toString()}");
      emit(CategoryListError(e.toString()));
    }
  }
}
