import 'package:o_driver/features/orders/models/order_histories_model/order_histories_model.dart';
import 'package:o_driver/features/orders/models/order_update/order_update.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/order.dart';
import 'package:o_driver/features/orders/models/pending_order_list_model/pending_order_list_model.dart';
import 'package:o_driver/features/orders/models/status_model/status_model.dart';
import 'package:o_driver/features/orders/models/this_week_delivery_model/this_week_delivery_model.dart';
import 'package:o_driver/features/orders/models/todays_job_model/todays_job_model.dart';
import 'package:o_driver/features/orders/models/todays_pending_order_model/todays_pending_order_model.dart';
import 'package:o_driver/services/api_service.dart';

abstract class IOrderRepo {
  Future<PendingOrderListModel> getTotalOrders(
      {required String status, required String date});
  Future<TodaysPendingOrderModel> getTodaysPendingOrders();
  Future<TodaysJobModel> getTodaysJobs();
  Future<void> acceptOrder({required int orderId, required bool isAccepted});
  Future<StatusModel> getStatusList();
  Future<ThisWeekDeliveryModel> getThisWeekDeliveryList();
  Future<OrderUpdate> updateOrder({required String id, required String status});
  Future<OrderHistoriesModel> getOrderHistory();
  Future<Order> getOrderDetails({required int orderId});
  Future<String> updateOrderProcess(
      {required int? orderId, required String? status});
}

class OrderRepo implements IOrderRepo {
  final _dio = getDio();
  @override
  Future<PendingOrderListModel> getTotalOrders(
      {required String status, required String date}) async {
    var response = await _dio.get('/driver/orders',
        queryParameters: {'status': status, 'date': date});

    return PendingOrderListModel.fromMap(response.data);
  }

  @override
  Future<TodaysPendingOrderModel> getTodaysPendingOrders() async {
    var response = await _dio.get('/driver/todays-pending');

    return TodaysPendingOrderModel.fromMap(response.data);
  }

  @override
  Future<TodaysJobModel> getTodaysJobs() async {
    var response = await _dio.get('/driver/todays');

    return TodaysJobModel.fromMap(response.data);
  }

  @override
  Future<void> acceptOrder(
      {required int orderId, required bool isAccepted}) async {
    await _dio.get('/driver/order/accept/$orderId',
        queryParameters: {'is_accepted': isAccepted});
  }

  @override
  Future<StatusModel> getStatusList() async {
    var response = await _dio.get('/driver/orders-status');

    return StatusModel.fromMap(response.data);
  }

  @override
  Future<ThisWeekDeliveryModel> getThisWeekDeliveryList() async {
    var response = await _dio.get('/driver/this-week');

    return ThisWeekDeliveryModel.fromMap(response.data);
  }

  @override
  Future<OrderUpdate> updateOrder(
      {required String id, required String status}) async {
    var response = await _dio.get('/driver/orders/$id/update?status=$status');

    return OrderUpdate.fromMap(response.data);
  }

  @override
  Future<OrderHistoriesModel> getOrderHistory() async {
    var response = await _dio.get('/driver/order-histories');

    return OrderHistoriesModel.fromMap(response.data);
  }

  @override
  Future<Order> getOrderDetails({required int orderId}) async {
    var response = await _dio.get('/driver/orders/$orderId');

    return Order.fromMap(response.data['data']['order']);
  }

  @override
  Future<String> updateOrderProcess(
      {required int? orderId, required String? status}) async {
    var response = await _dio.get('/driver/order/process',
        queryParameters: {'id': orderId, 'status': status});

    return response.data['message'];
  }
}
