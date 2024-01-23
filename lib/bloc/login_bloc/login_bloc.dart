// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/login_bloc/login_event.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailPassword>((event, emit) async {
      emit(LoginLoading());
      try {
        final bool loginSuccess = await login(event.email, event.password);
        if (loginSuccess) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Invalid email or password'));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    final url = Uri.parse('https://ondgo.in/api/user-login.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'API_KEY':
            'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06',
      },
      body: json.encode({
        'email_mobile': email,
        'password': password,
        'deviceId': 'XAMABJ',
        'deviceModel': 'Samsung',
        'fcmToken': 'fsdfusf908f0s8ffasdf',
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Full response: ${response.body}');
      return data['status'] == true;
      // ['status'] == true;
    } else {
      Exception(
          'Failed to sign in user with status code: ${response.statusCode}');
      print('Error response: ${response.body}');
      return false;
    }
  }
}
