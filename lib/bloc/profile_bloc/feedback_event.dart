abstract class FeedbackEvent {}

class SubmitFeedback extends FeedbackEvent {
  final String comment;
  SubmitFeedback({required this.comment});
}