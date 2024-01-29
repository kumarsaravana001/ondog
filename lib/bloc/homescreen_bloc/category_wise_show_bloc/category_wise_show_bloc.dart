import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/models/homescreen_model/category_list_wise_model.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  final LoginBloc loginBloc;
  final CategoryListBloc categoryListBloc;

  ShowBloc(this.loginBloc, this.categoryListBloc) : super(ShowInitial()) {
    on<FetchShows>(_onFetchShows);
  }

  void _onFetchShows(FetchShows event, Emitter<ShowState> emit) async {
    try {
      emit(ShowLoading());
      final userId = loginBloc.userId;
      final categoryId = categoryListBloc.categoryId;
      print('Fetching shows for userId: $userId and categoryId: $categoryId');
      final shows = await fetchShows(userId!, categoryId!);
      emit(ShowLoaded(shows));
    } catch (e) {
      emit(ShowError(e.toString()));
    }
  }

  Future<List<CategoryWiseListData>> fetchShows(
      String userId, int categoryId) async {
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');
    final body = json.encode({'user_id': userId, 'category_id': categoryId});
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'API_KEY':
              'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06',
        },
        body: body);
    print('Category List Response Status: ${response.statusCode}');
    print('Category List Response Body: ${response.body}');
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        List<dynamic> data = responseData['data'];
        return data.map((item) => CategoryWiseListData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch shows');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
