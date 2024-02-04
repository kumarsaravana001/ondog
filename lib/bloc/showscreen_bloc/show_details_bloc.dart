import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/show_details_state.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

import 'package:http/http.dart' as http;

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(UserDetailInitial()) {
    on<FetchUserDetail>(_onFetchUserDetail);
  }

  void _onFetchUserDetail(
      FetchUserDetail event, Emitter<UserDetailState> emit) async {
    try {
      emit(UserDetailLoading());
      final userDetails = await _fetchUserDetails(event.showId);
      emit(UserDetailLoaded(userDetails));
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }

  Future<List<ShowDetailsData>> _fetchUserDetails(int showId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');

    final url = Uri.parse('https://ondgo.in/api/user-show-details.php');
    final body = json.encode({
      'show_id': showId,
      'user_id': userId,
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
