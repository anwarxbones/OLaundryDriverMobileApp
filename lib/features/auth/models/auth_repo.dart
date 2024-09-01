import 'package:dio/dio.dart';
import 'package:dry_cleaners_driver/features/auth/models/login_model/login_model.dart';
import 'package:dry_cleaners_driver/features/auth/models/register_model/register_model.dart';
import 'package:dry_cleaners_driver/services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IAuthRepo {
  Future<LoginModel> login(
      {required String contact,
      required String password,
      required String deviceKey});
  Future<RegisterModel> register({required Map<String, dynamic> data});
  Future<void> logout({required String deviceKey});
}

class AuthRepo implements IAuthRepo {
  final _dio = getDio();
  @override
  Future<LoginModel> login(
      {required String contact,
      required String password,
      required String deviceKey}) async {
    final token = await FirebaseMessaging.instance.getToken();
    var response = await _dio.post('/driver/login',
        data: {'contact': contact, 'password': password, 'device_key': token});

    return LoginModel.fromMap(response.data);
  }

  @override
  Future<void> logout({required String deviceKey}) async {
    final deviceKey = await FirebaseMessaging.instance.getToken();
    await _dio
        .get('/driver/logout', queryParameters: {'device_key': deviceKey});
  }

  @override
  Future<RegisterModel> register({required Map<String, dynamic> data}) async {
    final token = await FirebaseMessaging.instance.getToken();
    var response =
        await _dio.post('/driver/register', data: FormData.fromMap(data));

    return RegisterModel.fromMap(response.data);
  }
}