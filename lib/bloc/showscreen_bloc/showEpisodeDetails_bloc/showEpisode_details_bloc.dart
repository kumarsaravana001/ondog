import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_state.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showEpisodeDetails_module.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class UserEpisodeDetailBloc
    extends Bloc<UserEpisodeDetailEvent, UserEpisodeDetailState> {
  UserEpisodeDetailBloc() : super(UserEpisodeDetailInitial()) {
    on<FetchUserEpisodeDetail>(onFetchUserEpisodeDetail);
  }

  void onFetchUserEpisodeDetail(FetchUserEpisodeDetail event,
      Emitter<UserEpisodeDetailState> emit) async {
    try {
      emit(UserEpisodeDetailLoading());
      final episodeDetails = await fetchUserEpisodeDetails(event.showId);
      emit(UserEpisodeDetailLoaded(episodeDetails, showId: event.showId));
    } catch (e) {
      print("Error fetching episode details: $e");
      emit(UserEpisodeDetailError(e.toString()));
    }
  }

  Future<List<ShowEpisodeDetailsData>> fetchUserEpisodeDetails(
      int showId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse('https://ondgo.in/api/user-episode-details.php');
    final body = json.encode({
      'user_id': userId,
      'show_id': showId,
    });
    print("showid from UserEpisodeDetailBloc : ${showId}");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API_KEY': ApiUrl.apiKey,
        },
        body: body,
      );
      print("Response status UserEpisodeDetailBloc: ${response.statusCode}");
      print("Response body UserEpisodeDetailBloc: ${response.body}");
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          List<dynamic> dataList = responseData['data'];
          return dataList
              .map<ShowEpisodeDetailsData>(
                  (item) => ShowEpisodeDetailsData.fromJson(item))
              .toList();
        } else {
          throw Exception('Failed to fetch episode details');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
