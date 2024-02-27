import 'package:ondgo_flutter/models/profile_model/event_model.dart';

abstract class EventDetailsState {}

class EventDetailsInitial extends EventDetailsState {}

class EventDetailsLoading extends EventDetailsState {}

class EventDetailsLoaded extends EventDetailsState {
  final List<EventData> eventDetails;

  EventDetailsLoaded(this.eventDetails);
}

class EventDetailsError extends EventDetailsState {
  final String message;

  EventDetailsError(this.message);
}
