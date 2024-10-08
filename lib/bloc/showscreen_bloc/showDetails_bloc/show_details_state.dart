import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';

abstract class UserShowDetailState {}

class UserShowDetailInitial extends UserShowDetailState {}

class UserShowDetailLoading extends UserShowDetailState {}

class UserShowDetailLoaded extends UserShowDetailState {
  final List<ShowDetailsData> userDetails;
  final int showId;

  UserShowDetailLoaded(this.userDetails, {required this.showId});
}

class UserShowDetailError extends UserShowDetailState {
  final String message;

  UserShowDetailError(this.message);
}
