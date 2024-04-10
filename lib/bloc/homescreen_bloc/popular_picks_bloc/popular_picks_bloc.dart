// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc/popular_picks_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc/popular_picks_state.dart';
import 'package:ondgo_flutter/models/homescreen_model/popular_picks_model.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class PopularPicksBloc extends Bloc<PopularPicksEvent, PopularPicksState> {
  PopularPicksBloc() : super(PopularPicksInitial()) {
    on<FetchPopularPicks>(_onFetchPopularPicks);
  }

  void _onFetchPopularPicks(
      PopularPicksEvent event, Emitter<PopularPicksState> emit) async {
    try {
      emit(PopularPicksLoading());
      final popularPicksData = await fetchPopularPicks();
      emit(PopularPicksLoaded(popularPicksData));
    } catch (e) {
      emit(PopularPicksError(e.toString()));
      // print('Error occurred in _onFetchPopularPicks: $e');
    }
  }

  Future<List<PopularpicksData>> fetchPopularPicks() async {
    // String? userId = loginBloc.userId;
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse(ApiBase.popularPicks);

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
      // print('Picks Response Status: ${response.statusCode}');
      // print('Picks Response Body: ${response.body}');
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          List<dynamic> dataList = responseData['data'];
          List<PopularpicksData> popularPicks =
              dataList.map((item) => PopularpicksData.fromJson(item)).toList();
          return popularPicks;
        } else {
          throw Exception('Failed to fetch popular picks');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
