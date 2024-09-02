import 'package:o_driver/features/profile/logic/profile_notfier.dart';
import 'package:o_driver/features/profile/models/profile_repo.dart';
import 'package:o_driver/features/profile/models/user_model/user_model.dart';
import 'package:o_driver/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepoProvider = Provider<IProfileRepo>((ref) {
  return ProfileRepo();
});

final userDetailsProvider =
    StateNotifierProvider<UserDetailsNotifier, ApiState<UserModel>>((ref) {
  return UserDetailsNotifier(ref.watch(profileRepoProvider));
});
final userProfileUpdateProvider =
    StateNotifierProvider<ProfileUpdateNotifier, ApiState<String>>((ref) {
  return ProfileUpdateNotifier(ref.watch(profileRepoProvider));
});
final userPasswordUpdateProvider =
    StateNotifierProvider<PasswordUpdateNotifier, ApiState<String>>((ref) {
  return PasswordUpdateNotifier(ref.watch(profileRepoProvider));
});
final userDecativeProvider =
    StateNotifierProvider<ProfileDeactivateNotifier, ApiState<String>>((ref) {
  return ProfileDeactivateNotifier(ref.watch(profileRepoProvider));
});
