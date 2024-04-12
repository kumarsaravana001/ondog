import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
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

    var url = Uri.parse(ApiBase.userVideoDetails);
    var body = json.encode({
      'user_id': userId,
      'show_id': showId,
      'episode_id': episodeId,
    });

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );

    print('HTTP status code: ${response.statusCode}'); // Log the status code
    print('HTTP response: ${response.body}'); // Log the raw JSON response

    //   if (response.statusCode == 200) {
    //     var jsonData = json.decode(response.body);

    //     if (jsonData['status'] == true) {
    //       List<dynamic> dataList = jsonData['data'];
    //       return dataList
    //           .map<EpisodeDetailData>((item) => EpisodeDetailData.fromJson(item))
    //           .toList();
    //     } else {
    //       throw Exception('Failed to fetch video details');
    //     }
    //   } else {
    //     throw Exception('Failed with status code: ${response.statusCode}');
    //   }
    // }
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == true) {
        // Check if 'data' is a key in the JSON, if it is null, or if it is not a list
        if (jsonData.containsKey('data') &&
            jsonData['data'] != null &&
            jsonData['data'] is List) {
          List<dynamic> dataList = jsonData['data'];
          return dataList
              .map((item) => EpisodeDetailData.fromJson(item))
              .toList();
        } else {
          // Log the problem and the type of jsonData['data']
          print(
              'jsonData[data] is ${jsonData['data']} with type ${jsonData['data'].runtimeType}');
          throw Exception(
              'jsonData[data] is either not a list, null, or missing');
        }
      } else {
        throw Exception('API status is false: ${jsonData['message']}');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     print(
  //         'jsonData[data] is ${jsonData['data']} with type ${jsonData['data']?.runtimeType}');

  //     if (jsonData['status'] == true) {
  //       // jsonData['data'] is null when there is no data found, so we should handle this case
  //       if (jsonData['data'] == null) {
  //         // Return an empty list if there is no data
  //         return [];
  //       }

  //       // If jsonData['data'] is a list, parse it
  //       if (jsonData['data'] is List) {
  //         List<dynamic> dataList = jsonData['data'];
  //         return dataList
  //             .map((item) => EpisodeDetailData.fromJson(item))
  //             .toList();
  //       } else {
  //         throw Exception(
  //             'jsonData[data] is not in the expected format (List)');
  //       }
  //     } else {
  //       throw Exception('API status is false: ${jsonData['message']}');
  //     }
  //   } else {
  //     throw Exception('Failed with status code: ${response.statusCode}');
  //   }
  // }
}
