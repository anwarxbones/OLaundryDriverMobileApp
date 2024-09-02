import 'package:o_driver/features/auth/models/auth_repo.dart';
import 'package:o_driver/features/auth/models/login_model/login_model.dart';
import 'package:o_driver/features/auth/models/register_model/register_model.dart';
import 'package:o_driver/services/api_state.dart';
import 'package:o_driver/services/network_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<ApiState<LoginModel>> {
  LoginNotifier(this._repo, this.deviceKey) : super(const ApiState.initial());
  final IAuthRepo _repo;
  final String deviceKey;

  Future<void> login({
    required String contact,
    required String password,
  }) async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(
          data: await _repo.login(
              contact: contact, password: password, deviceKey: deviceKey));
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class RegistrationNotifier extends StateNotifier<ApiState<RegisterModel>> {
  RegistrationNotifier(this._repo) : super(const ApiState.initial());
  final IAuthRepo _repo;

  Future<void> register({
    required Map<String, dynamic> data,
  }) async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await _repo.register(data: data));
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class LogOutNotifier extends StateNotifier<ApiState<String>> {
  LogOutNotifier(this._repo, this.deviceKey) : super(const ApiState.initial());
  final IAuthRepo _repo;
  final String deviceKey;

  Future<void> logout() async {
    state = const ApiState.loading();
    try {
      await _repo.logout(deviceKey: deviceKey);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
