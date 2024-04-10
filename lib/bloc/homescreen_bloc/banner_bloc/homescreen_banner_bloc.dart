import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_state.dart';
import 'package:ondgo_flutter/models/homescreen_model/banner_model.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class HomeScreenBannerBloc
    extends Bloc<HomeScreenBannerEvent, HomeScreenBannerState> {
  // final LoginBloc loginBloc;
  HomeScreenBannerBloc() : super(HomeScreenBannerInitial()) {
    on<FetchBanners>(_onFetchBanners);
  }

  void _onFetchBanners(
      HomeScreenBannerEvent event, Emitter<HomeScreenBannerState> emit) async {
    try {
      emit(HomeScreenBannerLoading());
      final banners = await fetchBanners();
      emit(HomeScreenBannerLoaded(banners));
    } catch (e) {
      emit(HomeScreenBannerError(e.toString()));
    }
  }

  Future<List<Data>> fetchBanners() async {
    // String? userId = loginBloc.userId;
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');

    final url = Uri.parse(ApiBase.homescreenBanner);

    if (userId == null) {
      throw Exception('User ID is null home');
    }

    final body = json.encode({
      'user_id': userId,
    });
    // print('userid: ${userId}');

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
          List<Data> banners =
              dataList.map((item) => Data.fromJson(item)).toList();

          return banners;
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
