import 'package:o_driver/features/auth/logic/auth_notifier.dart';
import 'package:o_driver/features/auth/models/auth_repo.dart';
import 'package:o_driver/features/auth/models/login_model/login_model.dart';
import 'package:o_driver/features/auth/models/register_model/register_model.dart';
import 'package:o_driver/features/core/logic/misc_provider.dart';
import 'package:o_driver/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
//
//
final authProvider = Provider<IAuthRepo>((ref) {
  return AuthRepo();
});

//
//
//
//login Provider
final loginProvider =
    StateNotifierProvider<LoginNotifier, ApiState<LoginModel>>((ref) {
  return LoginNotifier(
      ref.watch(authProvider), ref.watch(onesignalDeviceIDProvider));
});
//
//
//
//login Provider
final registerProvider =
    StateNotifierProvider<RegistrationNotifier, ApiState<RegisterModel>>((ref) {
  return RegistrationNotifier(ref.watch(authProvider));
});
//
//
//
//logout Provider
final logoutProvider =
    StateNotifierProvider<LogOutNotifier, ApiState<String>>((ref) {
  return LogOutNotifier(
      ref.watch(authProvider), ref.watch(onesignalDeviceIDProvider));
});
