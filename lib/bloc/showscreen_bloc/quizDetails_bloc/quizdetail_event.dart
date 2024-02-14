abstract class QuizDetailsEvent {}

class FetchQuizDetails extends QuizDetailsEvent {
  final int showId;
  final int episodeId;

  FetchQuizDetails({required this.showId, required this.episodeId});
}
