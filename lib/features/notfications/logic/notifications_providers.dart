import 'package:dry_cleaners_driver/features/notfications/logic/notifications_notifiers.dart';
import 'package:dry_cleaners_driver/features/notfications/models/notfication_repo.dart';
import 'package:dry_cleaners_driver/features/notfications/models/notification_list_model/notification_list_model.dart';
import 'package:dry_cleaners_driver/services/api_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepoProvider = Provider<INotificationRepo>((ref) {
  return NotificationRepo();
});

//
//
//
//
final allNotificationsProvider = StateNotifierProvider<NotificationListNotifier,
    ApiState<NotificationListModel>>((ref) {
  return NotificationListNotifier(ref.watch(profileRepoProvider));
});
//
//
//
//
final readNotificationsProvider = StateNotifierProvider.family
    .autoDispose<ReadNotificationNotifier, ApiState<String>, String>((ref, id) {
  return ReadNotificationNotifier(ref.watch(profileRepoProvider), id);
});
//
//
//
//
final deleteNotificationsProvider = StateNotifierProvider.family
    .autoDispose<DeleteNotificationNotifier, ApiState<String>, String>(
        (ref, id) {
  return DeleteNotificationNotifier(ref.watch(profileRepoProvider), id);
});
