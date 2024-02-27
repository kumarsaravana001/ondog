import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_state.dart';
import 'package:ondgo_flutter/models/profile_model/purchase_model.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    on<FetchPurchaseUrls>(_onFetchPurchaseUrls);
  }

  void _onFetchPurchaseUrls(
      FetchPurchaseUrls event, Emitter<PurchaseState> emit) async {
    emit(PurchaseLoading());
    try {
      final purchaseUrls = await _fetchPurchaseUrls();
      emit(PurchaseLoaded(purchaseUrls));
    } catch (e) {
      emit(PurchaseError(e.toString()));
    }
  }

  Future<List<PurchaseUrl>> _fetchPurchaseUrls() async {
    String? userId = Hive.box('sessionBox').get('userId');
    var url = Uri.parse('https://ondgo.in/api/user-purchase.php');
    var body = json.encode({
      'user_id': userId,
    });

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    // print("Resp from purchase ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> jsonUrls = json.decode(response.body);
      return jsonUrls
          .map<PurchaseUrl>((jsonUrl) => PurchaseUrl.fromJson(jsonUrl))
          .toList();
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
