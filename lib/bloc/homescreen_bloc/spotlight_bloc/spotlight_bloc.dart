import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/spotlight_bloc/spotlight_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/spotlight_bloc/spotlight_state.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';
import '../../../models/homescreen_model/spotlight_module.dart';

class HomeScreenSpotLightBloc
    extends Bloc<HomeScreenSpotlightEvent, HomeScreenSpotlightState> {
  HomeScreenSpotLightBloc() : super(HomeScreenSpotlightInitial()) {
    on<FetchSpotlight>(_onFetchSpotlight);
  }

  void _onFetchSpotlight(HomeScreenSpotlightEvent event,
      Emitter<HomeScreenSpotlightState> emit) async {
    try {
      emit(HomeScreenSpotlightLoading());
      final spotlightData = await fetchSpotlight();
      emit(HomeScreenSpotlightLoaded(spotlightData));
    } catch (e) {
      // print(
      //     '++++++++++++++++++++++++++++++++++++Error occurred in _onFetchPopularPicks: $e');
      emit(HomeScreenSpotlightError(e.toString()));
    }
  }

  Future<List<SpotLightModelData>> fetchSpotlight() async {
    // String? userId = loginBloc.userId;
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');

    final url = Uri.parse(ApiBase.spotlight);

    if (userId == null) {
      throw Exception('User ID is null home');
    }

    final body = json.encode({
      'user_id': userId,
    });
    // print('userid ++++++++++++++++++++++++++++++++++++++++++++: ${userId}');

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

      // print('Banner Response Status: ${response.statusCode}');
      // print('Banner Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          List<dynamic> dataList = responseData['data'];
          List<SpotLightModelData> spotlight = dataList
              .map((item) => SpotLightModelData.fromJson(item))
              .toList();

          return spotlight;
        } else {
          throw Exception('Failed to fetch banners');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
