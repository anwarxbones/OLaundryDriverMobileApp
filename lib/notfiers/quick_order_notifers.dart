import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/quick_order_model/quick_order_model.dart';
import 'package:laundry_customer/repos/quick_order_repo.dart';
import 'package:laundry_customer/services/api_state.dart';
import 'package:laundry_customer/services/network_exceptions.dart';

class QuickOrderNotifers extends StateNotifier<ApiState<QuickOrderModel>> {
  QuickOrderNotifers(this.repo) : super(const ApiState.initial());
  final IQuickOrderRepo repo;

  Future<void> placeQuickOrder(Map<String, dynamic> data) async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await repo.placeQuickOrder(data));
    } catch (e) {
      debugPrint(e.toString());
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
