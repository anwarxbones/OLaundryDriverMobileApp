import 'package:dio/dio.dart';

import '../../../services/api_service.dart';

class NotficationHelper {
  static final Dio _dio = getDio();

  static Future<void> readNotfication({required String id}) async {
    await _dio.post('/driver/notifications/$id');
  }

  static Future<void> deleteNotfication({required String id}) async {
    await _dio.delete('/driver/notifications/$id');
  }
}
