// PurchaseEvent
import 'package:ondgo_flutter/models/profile_model/rewards_module.dart';

abstract class RewardsEvent {}

class FetchRewardsUrls extends RewardsEvent {}

abstract class RewardsState {}

class RewardsInitial extends RewardsState {}

class RewardsLoading extends RewardsState {}

class RewardsLoaded extends RewardsState {
  final List<RewardsUrl> rewardsUrls;

  RewardsLoaded(this.rewardsUrls);
}
