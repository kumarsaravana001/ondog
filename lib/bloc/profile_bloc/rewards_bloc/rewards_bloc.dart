import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_state.dart';
import 'package:ondgo_flutter/models/profile_model/rewards_module.dart';

import '../../../networkconfig/api_url.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsInitial()) {
    on<FetchRewardsUrls>(_onFetchRewardsUrls);
  }

  void _onFetchRewardsUrls(
      FetchRewardsUrls event, Emitter<RewardsState> emit) async {
    emit(RewardsLoading());
    try {
      final RewardsUrls = await _fetchRewardsUrls();
      emit(RewardsLoaded(RewardsUrls));
    } catch (e) {
      emit(RewardsError(e.toString()));
    }
  }

  Future<List<RewardsUrl>> _fetchRewardsUrls() async {
    String? userId = Hive.box('sessionBox').get('userId');
    var url = Uri.parse('https://ondgo.in/api/user-Rewards.php');
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
    // print("Resp from Rewards ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> jsonUrls = json.decode(response.body);
      return jsonUrls
          .map<RewardsUrl>((jsonUrl) => RewardsUrl.fromJson(jsonUrl))
          .toList();
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
