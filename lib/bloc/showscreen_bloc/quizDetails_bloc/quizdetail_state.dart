import 'package:ondgo_flutter/models/showscreen_modules/quizdetails_module.dart';

abstract class QuizDetailsState {}

class QuizDetailsInitial extends QuizDetailsState {}

class QuizDetailsLoading extends QuizDetailsState {}

class QuizDetailsLoaded extends QuizDetailsState {
  final List<QuizDetailsData> quizDetails;
  final int showId;
  final int episodeId;

  QuizDetailsLoaded(this.quizDetails,
      {required this.showId, required this.episodeId});
}

class QuizDetailsError extends QuizDetailsState {
  final String message;

  QuizDetailsError(this.message);
}
