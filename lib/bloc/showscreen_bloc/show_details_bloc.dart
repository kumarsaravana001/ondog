// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/show_details_state.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';
import 'package:http/http.dart' as http;

class UserShowDetailBloc
    extends Bloc<UserShowDetailEvent, UserShowDetailState> {
  UserShowDetailBloc() : super(UserShowDetailInitial()) {
    on<FetchUserShowDetail>(onFetchUserDetail);
  }

  void onFetchUserDetail(
      FetchUserShowDetail event, Emitter<UserShowDetailState> emit) async {
    try {
      emit(UserShowDetailLoading());
      final userDetails = await fetchUserShowDetails(event.showId);
      print("Fetched userDetails: ${userDetails.length}");
      emit(UserShowDetailLoaded(userDetails));
    } catch (e) {
      print("Error fetching user details: $e");
      emit(UserShowDetailError(e.toString()));
    }
  }

  Future<List<ShowDetailsData>> fetchUserShowDetails(int showId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    print("Fetching details for showId: $showId");

    final url = Uri.parse('https://ondgo.in/api/user-show-details.php');
    final body = json.encode({
      'show_id': showId,
      'user_id': userId,
    });
    print("show from Show Screen: ${showId}");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API_KEY': ApiUrl.apiKey,
        },
        body: body,
      );
      print("Response status show screen: ${response.statusCode}");
      print("Response body show screen: ${response.body}");
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          List<dynamic> dataList = responseData['data'];
          List<ShowDetailsData> userDetailsList = dataList
              .map<ShowDetailsData>((item) => ShowDetailsData.fromJson(item))
              .toList();
          return userDetailsList;
        } else {
          throw Exception('Failed to fetch user details');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
