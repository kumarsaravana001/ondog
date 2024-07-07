import '../../models/reels_model/reels_model.dart';

abstract class UserReelsState {}

class UserReelsInitial extends UserReelsState {}

class UserReelsLoading extends UserReelsState {}

class UserReelsLoaded extends UserReelsState {
  final List<ReelsData> reels;

  UserReelsLoaded(this.reels);
}

class UserReelsError extends UserReelsState {
  final String message;

  UserReelsError(this.message);
}
