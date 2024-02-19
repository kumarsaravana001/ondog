import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeDetails_bloc/epidoseDetail_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeDetails_bloc/episodeDetail_state.dart';
import '../../../models/showscreen_modules/episodeDetail_module.dart';
import '../../../networkconfig/api_url.dart';

class VideoDetailsBloc extends Bloc<VideoDetailsEvent, VideoDetailsState> {
  VideoDetailsBloc() : super(VideoDetailsInitial()) {
    on<FetchVideoDetails>(_onFetchVideoDetails);
  }

  void _onFetchVideoDetails(
      FetchVideoDetails event, Emitter<VideoDetailsState> emit) async {
    emit(VideoDetailsLoading());
    try {
      final videoDetails =
          await _fetchVideoDetails(event.showId, event.episodeId);
      emit(VideoDetailsLoaded(
        videoDetails,
        showId: event.showId,
        episodeId: event.episodeId,
      ));
    } catch (e) {
      emit(VideoDetailsError(e.toString()));
    }
  }

  Future<List<EpisodeDetailData>> _fetchVideoDetails(
      int showId, int episodeId) async {
    String? userId = Hive.box('sessionBox').get('userId');
    var url = Uri.parse('https://ondgo.in/api/user-video-details.php');
    var body = json.encode({
      'user_id': userId,
      'show_id': showId,
      'episode_id': episodeId,
    });
    print("showid from VideoDetailsBloc : ${showId}");
    print("episodeid from VideoDetailsBloc : ${episodeId}");
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        List<dynamic> dataList = jsonData['data'];
        return dataList
            .map<EpisodeDetailData>((item) => EpisodeDetailData.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch video details');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
