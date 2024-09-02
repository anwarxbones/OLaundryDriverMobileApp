import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:o_driver/features/profile/models/profile_repo.dart';
import 'package:o_driver/features/profile/models/user_model/user_model.dart';
import 'package:o_driver/services/api_state.dart';
import 'package:o_driver/services/network_exceptions.dart';

class UserDetailsNotifier extends StateNotifier<ApiState<UserModel>> {
  UserDetailsNotifier(this._repo) : super(const ApiState.initial()) {
    //Only Use When We wanna get the data without Button Tap
    getUserDetails();
  }

  final IProfileRepo _repo;

  Future<void> getUserDetails() async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await _repo.getUserDetails());
    } catch (e) {
      if (!mounted) {}
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class ProfileUpdateNotifier extends StateNotifier<ApiState<String>> {
  ProfileUpdateNotifier(this._repo) : super(const ApiState.initial());
  final IProfileRepo _repo;

  Future<void> updateProfile(
      {required Map<String, dynamic> data, File? file}) async {
    state = const ApiState.loading();
    try {
      await _repo.updateProfile(data: data, file: file);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class PasswordUpdateNotifier extends StateNotifier<ApiState<String>> {
  PasswordUpdateNotifier(this._repo) : super(const ApiState.initial());
  final IProfileRepo _repo;

  Future<void> updatePassword({required Map<String, dynamic> data}) async {
    state = const ApiState.loading();
    try {
      await _repo.updatePassword(data: data);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class ProfileDeactivateNotifier extends StateNotifier<ApiState<String>> {
  ProfileDeactivateNotifier(this._repo) : super(const ApiState.initial());
  final IProfileRepo _repo;

  Future<void> deactivate() async {
    state = const ApiState.loading();
    try {
      await _repo.deactivate();
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
