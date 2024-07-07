abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackSubmitting extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {
  final String message;
  FeedbackSuccess(this.message);
}

class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError(this.message);
}