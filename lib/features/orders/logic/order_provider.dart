import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:o_driver/features/core/logic/misc_provider.dart';
import 'package:o_driver/features/orders/logic/order_notfier.dart';
import 'package:o_driver/features/orders/models/order_histories_model/order_histories_model.dart';
import 'package:o_driver/features/orders/models/order_repo.dart';
import 'package:o_driver/features/orders/models/order_update/order_update.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/pending_order_list_model.dart';
import 'package:o_driver/features/orders/models/status_model/status_model.dart';
import 'package:o_driver/features/orders/models/this_week_delivery_model/this_week_delivery_model.dart';
import 'package:o_driver/features/orders/models/todays_job_model/todays_job_model.dart';
import 'package:o_driver/features/orders/models/todays_pending_order_model/todays_pending_order_model.dart';
import 'package:o_driver/features/orders/views/orders_tab.dart';
import 'package:o_driver/services/api_state.dart';

//
//
//
//
final iOrderRepoProvider = Provider<IOrderRepo>((ref) {
  return OrderRepo();
});
//
//
//
//
final totalOrderListProvider = StateNotifierProvider<TotalOrderListNotifier,
    ApiState<PendingOrderListModel>>((ref) {
  return TotalOrderListNotifier(
    ref.watch(iOrderRepoProvider),
    ref.watch(appOrderTabStatusProvider),
    DateFormat('dd-MM-yyyy').format(ref.watch(selectedDateProvider)),
  );
});
//
//
//
//
final orderDetailsProvider = StateNotifierProvider.family
    .autoDispose<OrderDetailsNotifier, ApiState<Order>, int>((ref, orderId) {
  return OrderDetailsNotifier(
    ref.watch(iOrderRepoProvider),
    orderId,
  );
});
//
//
//
//
// final totalAcceptedOrderListProvider = StateNotifierProvider<
//     TotalOrderListNotifier, ApiState<PendingOrderListModel>>((ref) {
//   return TotalOrderListNotifier(ref.watch(iOrderRepoProvider), '1');
// });
//
//
//
//
final todaysPendingOrderListProvider = StateNotifierProvider<
    TodaysPendingOrderListNotifier, ApiState<TodaysPendingOrderModel>>((ref) {
  return TodaysPendingOrderListNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final todaysJobListProvider =
    StateNotifierProvider<TodaysJobsListNotifier, ApiState<TodaysJobModel>>(
        (ref) {
  return TodaysJobsListNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final acceptOrderProvider =
    StateNotifierProvider<OrderAcceptNotifier, ApiState<String>>((ref) {
  return OrderAcceptNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final orderProcessUpdaterProvider =
    StateNotifierProvider<OrderProcessNotifer, ApiState<String>>(
  (ref) => OrderProcessNotifer(
    ref.watch(iOrderRepoProvider),
  ),
);
//
//
//
//
final statusListProvider =
    StateNotifierProvider<StatusListNotifier, ApiState<StatusModel>>((ref) {
  return StatusListNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final thisWeekDeliveryListProvider = StateNotifierProvider<
    ThisWeekDeliveryListNotifier, ApiState<ThisWeekDeliveryModel>>((ref) {
  return ThisWeekDeliveryListNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final orderUpdateProvider =
    StateNotifierProvider<OrderUpdateNotifier, ApiState<OrderUpdate>>((ref) {
  return OrderUpdateNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final orderHistoriesProvider = StateNotifierProvider<OrderHistoriesNotifier,
    ApiState<OrderHistoriesModel>>((ref) {
  return OrderHistoriesNotifier(
    ref.watch(iOrderRepoProvider),
  );
});
//
//
//
//
final sendSmsProvider = StateNotifierProvider<SendSmsNotifier, ApiState<bool>>(
  (ref) => SendSmsNotifier(
    ref.watch(iOrderRepoProvider),
  ),
);
