import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/profile_bloc/feedback_bloc/feedback_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/feedback_bloc/feedback_state.dart';
import '../../../../networkconfig/api_url.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<SubmitFeedback>(_onSubmitFeedback);
  }

  void _onSubmitFeedback(
      SubmitFeedback event, Emitter<FeedbackState> emit) async {
    emit(FeedbackSubmitting());
    try {
      final FeedbackModel result = await _submitFeedback(event.comment);
      if (result.status ?? false) {
        // print(
        //     "Emitting FeedbackSuccess with message: ${result.message}"); // Debug print

        emit(FeedbackSuccess(
            result.message ?? "Feedback submitted successfully."));
      } else {
        emit(FeedbackError(result.message ?? "Failed to submit feedback."));
      }
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }

  Future<FeedbackModel> _submitFeedback(String comment) async {
    String? userId = Hive.box('sessionBox').get('userId');
    var url = Uri.parse(ApiBase.feedBack);
    var body = json.encode({
      'user_id': userId,
      'comment': comment,
    });

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY': ApiUrl.apiKey,
      },
      body: body,
    );
    // print("the responce frm feedback ${response.body}");
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return FeedbackModel.fromJson(jsonData);
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}

class FeedbackModel {
  bool? status;
  String? message;

  FeedbackModel({this.status, this.message});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
