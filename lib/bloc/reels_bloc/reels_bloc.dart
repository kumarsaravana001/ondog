import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/reels_bloc/reels_event.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_state.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(ReelsInitial()) {
    on<FetchReelsDetails>(_onFetchReelsDetails);
  }

  Future<dynamic> fetchVideoDetails(int showId, int episodeId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-video-details.php');

    final body = json.encode({
      'user_id': userId,
      'show_id': showId,
      'episode_id': episodeId,
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
          return responseData['data'];
        } else {
          throw Exception('Failed to fetch video details');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onFetchReelsDetails(
      FetchReelsDetails event, Emitter<ReelsState> emit) async {
    try {
      emit(ReelsLoading());
      final videoDetails =
          await fetchVideoDetails(event.showId, event.episodeId);
      emit(ReelsLoaded(videoDetails));
    } catch (e) {
      emit(ReelsError(e.toString()));
    }
  }
}
