import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
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

      emit(UserShowDetailLoaded(userDetails, showId: event.showId));
    } catch (e) {
      print("Error fetching user details: $e");
      emit(UserShowDetailError(e.toString()));
    }
  }

  Future<List<ShowDetailsData>> fetchUserShowDetails(int showId) async {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    final url = Uri.parse(ApiBase.userShowDetails);
    final body = json.encode({
      'show_id': showId,
      'user_id': userId,
    });
    print("ShowDetailsData ${body}");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'API_KEY': ApiUrl.apiKey,
        },
        body: body,
      );
      print("Response status ShowDetailsData: ${response.statusCode}");
      print("Response body ShowDetailsData: ${response.body}");
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
