import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/profile_bloc/events_bloc/event_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/events_bloc/event_state.dart';
import 'package:ondgo_flutter/models/profile_model/event_model.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc() : super(EventDetailsInitial()) {
    on<FetchEventDetails>(_onFetchEventDetails);
  }

  void _onFetchEventDetails(
      FetchEventDetails event, Emitter<EventDetailsState> emit) async {
    emit(EventDetailsLoading());
    try {
      final eventDetails = await _fetchEventDetails();
      emit(EventDetailsLoaded(eventDetails));
    } catch (e) {
      emit(EventDetailsError(e.toString()));
    }
  }

  Future<List<EventData>> _fetchEventDetails() async {
    String? userId = Hive.box('sessionBox').get('userId');

    var url = Uri.parse('https://ondgo.in/api/user-event.php');
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
    print("*****Responce ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        List<dynamic> dataList = jsonData['data'];
        return dataList
            .map<EventData>((item) => EventData.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch event details');
      }
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
