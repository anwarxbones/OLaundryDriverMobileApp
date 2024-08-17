import 'package:dio/dio.dart';
import 'package:laundry_customer/models/quick_order_model/quick_order_model.dart';
import 'package:laundry_customer/services/api_service.dart';

abstract class IQuickOrderRepo {
  Future<QuickOrderModel> placeQuickOrder(Map<String, dynamic> data);
}

class QuickOrderRepo implements IQuickOrderRepo {
  final Dio _dio = getDio();
  @override
  Future<QuickOrderModel> placeQuickOrder(Map<String, dynamic> data) async {
    final Response response = await _dio.post('/quick-order', data: data);

    return QuickOrderModel.fromMap(response.data as Map<String, dynamic>);
  }
}
