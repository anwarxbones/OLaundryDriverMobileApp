import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:o_driver/features/orders/models/order_histories_model/order_histories_model.dart';
import 'package:o_driver/features/orders/models/order_repo.dart';
import 'package:o_driver/features/orders/models/order_update/order_update.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/pending_order_list_model.dart';
import 'package:o_driver/features/orders/models/status_model/status_model.dart';
import 'package:o_driver/features/orders/models/this_week_delivery_model/this_week_delivery_model.dart';
import 'package:o_driver/features/orders/models/todays_job_model/todays_job_model.dart';
import 'package:o_driver/features/orders/models/todays_pending_order_model/todays_pending_order_model.dart';
import 'package:o_driver/services/api_state.dart';
import 'package:o_driver/services/network_exceptions.dart';

class TotalOrderListNotifier
    extends StateNotifier<ApiState<PendingOrderListModel>> {
  TotalOrderListNotifier(
    this._repo,
    this.status,
    this.date,
  ) : super(const ApiState.initial()) {
    getTotalOrderList();
  }
  final String status;
  final IOrderRepo _repo;
  final String date;

  Future<void> getTotalOrderList() async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(
          data: await _repo.getTotalOrders(status: status, date: date));
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class TodaysPendingOrderListNotifier
    extends StateNotifier<ApiState<TodaysPendingOrderModel>> {
  TodaysPendingOrderListNotifier(
    this._repo,
  ) : super(const ApiState.initial()) {
    getTodaysPendingOrderList();
  }
  final IOrderRepo _repo;

  Future<void> getTodaysPendingOrderList() async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(data: await _repo.getTodaysPendingOrders());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class TodaysJobsListNotifier extends StateNotifier<ApiState<TodaysJobModel>> {
  TodaysJobsListNotifier(
    this._repo,
  ) : super(const ApiState.initial()) {
    getTodaysJobList();
  }
  final IOrderRepo _repo;

  Future<void> getTodaysJobList() async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(data: await _repo.getTodaysJobs());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class OrderAcceptNotifier extends StateNotifier<ApiState<String>> {
  OrderAcceptNotifier(
    this._repo,
  ) : super(const ApiState.initial());
  final IOrderRepo _repo;

  Future<void> acceptOrder(
      {required int orderId, required bool isAccepted}) async {
    state = const ApiState.loading();

    try {
      await _repo.acceptOrder(orderId: orderId, isAccepted: isAccepted);
      state = const ApiState.loaded(data: 'Succesfully Accepted');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class StatusListNotifier extends StateNotifier<ApiState<StatusModel>> {
  StatusListNotifier(
    this._repo,
  ) : super(const ApiState.initial()) {
    getStatusList();
  }
  final IOrderRepo _repo;

  Future<void> getStatusList() async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(data: await _repo.getStatusList());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class ThisWeekDeliveryListNotifier
    extends StateNotifier<ApiState<ThisWeekDeliveryModel>> {
  ThisWeekDeliveryListNotifier(
    this._repo,
  ) : super(const ApiState.initial()) {
    getThisWeekDeliveryList();
  }
  final IOrderRepo _repo;

  Future<void> getThisWeekDeliveryList() async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(data: await _repo.getThisWeekDeliveryList());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class OrderUpdateNotifier extends StateNotifier<ApiState<OrderUpdate>> {
  OrderUpdateNotifier(
    this._repo,
  ) : super(const ApiState.initial());
  final IOrderRepo _repo;

  Future<void> updateOrder({required String id, required String status}) async {
    state = const ApiState.loading();

    try {
      state = ApiState.loaded(
          data: await _repo.updateOrder(id: id, status: status));
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class OrderHistoriesNotifier
    extends StateNotifier<ApiState<OrderHistoriesModel>> {
  OrderHistoriesNotifier(
    this._repo,
  ) : super(const ApiState.initial()) {
    getOrderHistory();
  }
  final IOrderRepo _repo;

  Future<void> getOrderHistory() async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await _repo.getOrderHistory());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
