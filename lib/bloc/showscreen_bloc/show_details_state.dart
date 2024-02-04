import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';

abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final List<ShowDetailsData> userDetails;
  UserDetailLoaded(this.userDetails);
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);
}
