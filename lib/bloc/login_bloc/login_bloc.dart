// ignore_for_file: invalid_use_of_visible_for_testing_member, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/login_bloc/login_event.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_state.dart';

// class NoInternetException implements Exception {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String? authToken;
  String? userId;
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
        // if (e is NoInternetException) {
        //   emit(LoginNoInternet());
        // }
        //  else {
        print(e);
        emit(LoginFailure(e.toString()));
      }
    });
  }
  Future<bool> login(String email, String password) async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    // throw NoInternetException();
    // }
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

      if (data['status'] == true) {
        authToken = data['authToken'];
        userId = data['user_details']['user_id'];

        var box = Hive.box('sessionBox');
        await box.put('userId', userId);
        return true;
      }
      return false;
    } else {
      Exception(
          'Failed to sign in user with status code: ${response.statusCode}');
      return false;
    }
  }

  Future<void> logout() async {
    var box = Hive.box('sessionBox');
    await box.delete('userId');
    // Reset the state or navigate to login screen as necessary
    emit(LoginInitial());
  }
}
