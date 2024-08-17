import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/quick_order_model/quick_order_model.dart';
import 'package:laundry_customer/notfiers/quick_order_notifers.dart';
import 'package:laundry_customer/repos/quick_order_repo.dart';
import 'package:laundry_customer/services/api_state.dart';

final quickOrderRepoProvider = Provider<QuickOrderRepo>((ref) {
  return QuickOrderRepo();
});

final quickOrderProvder =
    StateNotifierProvider<QuickOrderNotifers, ApiState<QuickOrderModel>>((ref) {
  return QuickOrderNotifers(ref.watch(quickOrderRepoProvider));
});
