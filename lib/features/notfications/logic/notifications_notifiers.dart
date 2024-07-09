import 'package:dry_cleaners_driver/features/notfications/models/notfication_repo.dart';
import 'package:dry_cleaners_driver/features/notfications/models/notification_list_model/notification_list_model.dart';
import 'package:dry_cleaners_driver/services/api_state.dart';
import 'package:dry_cleaners_driver/services/network_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationListNotifier
    extends StateNotifier<ApiState<NotificationListModel>> {
  NotificationListNotifier(this._repo) : super(const ApiState.initial()) {
    getNotifications();
  }

  final INotificationRepo _repo;

  Future<void> getNotifications() async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await _repo.getNotifications());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class ReadNotificationNotifier extends StateNotifier<ApiState<String>> {
  ReadNotificationNotifier(this._repo, this._id)
      : super(const ApiState.initial());

  final INotificationRepo _repo;
  final String _id;

  Future<void> getNotifications() async {
    state = const ApiState.loading();
    try {
      await _repo.readNotfication(id: _id);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}

class DeleteNotificationNotifier extends StateNotifier<ApiState<String>> {
  DeleteNotificationNotifier(this._repo, this._id)
      : super(const ApiState.initial());

  final INotificationRepo _repo;
  final String _id;

  Future<void> deleteNotfication() async {
    state = const ApiState.loading();
    try {
      await _repo.deleteNotfication(id: _id);
      state = const ApiState.loaded(data: 'Success');
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
