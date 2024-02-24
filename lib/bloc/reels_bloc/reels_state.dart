import '../../models/reels_model/reels_model.dart';

abstract class ReelsState {}

class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {}

class ReelsLoaded extends ReelsState {
  final List<ReelsData> videoDetails;

  ReelsLoaded(this.videoDetails);
}

class ReelsError extends ReelsState {
  final String message;

  ReelsError(this.message);
}
