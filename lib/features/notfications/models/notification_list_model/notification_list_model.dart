import 'dart:convert';

import 'data.dart';

class NotificationListModel {
  String? message;
  Data? data;

  NotificationListModel({this.message, this.data});

  factory NotificationListModel.fromMap(Map<String, dynamic> data) {
    return NotificationListModel(
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotificationListModel].
  factory NotificationListModel.fromJson(String data) {
    return NotificationListModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotificationListModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
