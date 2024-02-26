import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_event.dart';

class RewardsError extends RewardsState {
  final String message;

  RewardsError(this.message);
}
