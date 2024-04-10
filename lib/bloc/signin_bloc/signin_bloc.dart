import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ondgo_flutter/bloc/signin_bloc/signin_event.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_state.dart';
import 'package:ondgo_flutter/networkconfig/api_url.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      var response = await _signInUser(
        event.email,
        event.password,
        event.firstName,
        event.lastName,
        event.mobileNumber,
      );
      if (response['status']) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure(response['message']));
      }
    } catch (e) {
      print("issue at Register ${e}");
      emit(SignInFailure(e.toString()));
    }
  }

  Future<Map<String, dynamic>> _signInUser(String email, String password,
      String firstName, String lastName, String mobileNumber) async {
    var url = Uri.parse(ApiBase.register);
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'API-Key':
          'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06',
    };
    var userData = {
      "first_name": firstName,
      "last_name": lastName,
      "mobile": mobileNumber,
      "email": email,
      "password": password,
    };

    var response =
        await http.post(url, headers: headers, body: json.encode(userData));
    // print('Status Code: ${response.statusCode}');
    // print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      // print('Response: $responseBody'); // Pri
      // print('responce body: ${responseBody['message']}');
      return responseBody;
    } else {
      throw Exception(
          'Failed to sign in user with status code: ${response.statusCode}');
    }
  }
}
