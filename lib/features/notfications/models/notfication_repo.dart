import 'package:dio/dio.dart';
import 'package:o_driver/features/notfications/models/notification_list_model/notification_list_model.dart';
import 'package:o_driver/services/api_service.dart';

abstract class INotificationRepo {
  Future<NotificationListModel> getNotifications();
  Future<void> readNotfication({required String id});
  Future<void> deleteNotfication({required String id});
}

class NotificationRepo implements INotificationRepo {
  final Dio _dio = getDio();
  @override
  Future<NotificationListModel> getNotifications() async {
    var response = await _dio.get('/driver/notifications');

    return NotificationListModel.fromMap(response.data);
  }

  @override
  Future<void> readNotfication({required String id}) async {
    await _dio.post('/driver/notifications/$id');
  }

  @override
  Future<void> deleteNotfication({required String id}) async {
    await _dio.delete('/driver/notifications/$id');
  }
}
