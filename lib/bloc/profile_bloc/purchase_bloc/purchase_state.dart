import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_event.dart';

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError(this.message);
}
