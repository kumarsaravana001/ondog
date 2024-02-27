import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/reels_bloc/reels_event.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_state.dart';

import '../../models/reels_model/reels_model.dart';
import '../../networkconfig/api_url.dart';

class UserReelsBloc extends Bloc<UserReelsEvent, UserReelsState> {
  UserReelsBloc() : super(UserReelsInitial()) {
    on<FetchUserReels>(_onFetchUserReels);
  }

  void _onFetchUserReels(
      FetchUserReels event, Emitter<UserReelsState> emit) async {
    emit(UserReelsLoading());
    try {
      final reelsList = await _fetchUserReels();
      emit(UserReelsLoaded(reelsList));
    } catch (e) {
      emit(UserReelsError(e.toString()));
    }
  }

  Future<List<ReelsData>> _fetchUserReels() async {
    String? userId =
        Hive.box('sessionBox').get('userId', defaultValue: "U588583");
    var url = Uri.parse('https://ondgo.in/api/user-reels.php');
    var body = json.encode({
      'user_id': userId,
    });

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );
    // print("Responce ${response.statusCode}");
    // print("Responce ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        List<dynamic> dataList = jsonData['data'];
        return dataList
            .map<ReelsData>((item) => ReelsData.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch user reels');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
