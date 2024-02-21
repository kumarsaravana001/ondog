import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import 'package:ondgo_flutter/models/homescreen_model/category_list_wise_model.dart';
import '../../../networkconfig/api_url.dart';

class CategoryWiseShowBloc
    extends Bloc<CategoryWiseShowEvent, CategoryWiseShowState> {
  CategoryWiseShowBloc() : super(CategoryWiseShowInitial()) {
    on<FetchCategoryWiseShows>(_onFetchCategoryWiseShows);
  }

  Future<List<CategoryWiseListData>> fetchShows(int categoryId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');

    final body = json.encode({
      'user_id': userId,
      'category_id': categoryId,
    });

    // print('Categorywise id ${categoryId}');
    try {
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
      final shows = await fetchShows(event.categoryId);
      emit(CategoryWiseShowLoaded(shows));
    } catch (e) {
      emit(CategoryWiseShowError(e.toString()));
    }
  }
}

class CategoryWiseShowBloc1
    extends Bloc<CategoryWiseShow1Event, CategoryWiseShow1State> {
  CategoryWiseShowBloc1() : super(CategoryWiseShow1Initial()) {
    on<FetchCategoryWiseShows1>(_onFetchCategoryWiseShows1);
  }

  Future<List<CategoryWiseListData>> fetchShows(int categoryIdd) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');

    final body = json.encode({
      'user_id': userId,
      'category_id': categoryIdd,
    });

    try {
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

  void _onFetchCategoryWiseShows1(FetchCategoryWiseShows1 event,
      Emitter<CategoryWiseShow1State> emit) async {
    try {
      emit(CategoryWiseShow1Loading());
      final shows = await fetchShows(event.categoryIdd);
      emit(CategoryWiseShow1Loaded(shows));
    } catch (e) {
      emit(CategoryWiseShow1Error(e.toString()));
    }
  }
}

class CategoryWiseShowBloc2
    extends Bloc<CategoryWiseShow2Event, CategoryWiseShow2State> {
  CategoryWiseShowBloc2() : super(CategoryWiseShow2Initial()) {
    on<FetchCategoryWiseShows2>(_onFetchCategoryWiseShows2);
  }

  Future<List<CategoryWiseListData>> fetchShows(int categoryIddd) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-category-wise-show.php');

    final body = json.encode({
      'user_id': userId,
      'category_id': categoryIddd,
    });

    // print('Categorywise id ${categoryIddd}');
    try {
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

  void _onFetchCategoryWiseShows2(FetchCategoryWiseShows2 event,
      Emitter<CategoryWiseShow2State> emit) async {
    try {
      emit(CategoryWiseShow2Loading());
      final shows = await fetchShows(event.categoryIddd);
      emit(CategoryWiseShow2Loaded(shows));
    } catch (e) {
      emit(CategoryWiseShow2Error(e.toString()));
    }
  }
}
