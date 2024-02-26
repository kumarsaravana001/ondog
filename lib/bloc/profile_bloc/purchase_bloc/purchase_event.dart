// PurchaseEvent
import 'package:ondgo_flutter/models/profile_model/purchase_model.dart';

abstract class PurchaseEvent {}

class FetchPurchaseUrls extends PurchaseEvent {}

// PurchaseState
abstract class PurchaseState {}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final List<PurchaseUrl> purchaseUrls;

  PurchaseLoaded(this.purchaseUrls);
}

