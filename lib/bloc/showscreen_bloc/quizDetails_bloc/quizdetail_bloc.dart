import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_state.dart';

import '../../../models/showscreen_modules/quizdetails_module.dart';
import '../../../networkconfig/api_url.dart'; // Adjust the path to your QuizDetailsModule model

class QuizDetailsBloc extends Bloc<QuizDetailsEvent, QuizDetailsState> {
  QuizDetailsBloc() : super(QuizDetailsInitial()) {
    on<FetchQuizDetails>(_onFetchQuizDetails);
  }

  void _onFetchQuizDetails(
      FetchQuizDetails event, Emitter<QuizDetailsState> emit) async {
    emit(QuizDetailsLoading());
    try {
      final quizDetails =
          await _fetchQuizDetails(event.showId, event.episodeId);
      emit(QuizDetailsLoaded(
        quizDetails,
        showId: event.showId,
        episodeId: event.episodeId,
      ));
    } catch (e) {
      print("Error fetching episode details: $e");
      emit(QuizDetailsError(e.toString()));
    }
  }

  Future<List<QuizDetailsData>> _fetchQuizDetails(
      int showId, int episodeId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    var url = Uri.parse(ApiBase.quizDetails);
    var body = json.encode({
      'user_id': userId,
      'show_id': showId,
      'episode_id': episodeId,
    });
    print("showid from QuizDetailsBloc : ${showId}");
    print("episodeid from QuizDetailsBloc : ${episodeId}");
    print("QuizDetailsBloc ${body}");

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );
    print("Response status QuizDetailsBloc: ${response.statusCode}");
    print("Response body QuizDetailsBloc: ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        List<dynamic> dataList = jsonData['data'];
        return dataList
            .map<QuizDetailsData>((item) => QuizDetailsData.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch quiz details');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
