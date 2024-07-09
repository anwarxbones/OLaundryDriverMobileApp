import 'dart:convert';

import 'data.dart';

class TodaysPendingOrderModel {
  String? message;
  Data? data;

  TodaysPendingOrderModel({this.message, this.data});

  factory TodaysPendingOrderModel.fromMap(Map<String, dynamic> data) {
    return TodaysPendingOrderModel(
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
  /// Parses the string and returns the resulting Json object as [TodaysPendingOrderModel].
  factory TodaysPendingOrderModel.fromJson(String data) {
    return TodaysPendingOrderModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TodaysPendingOrderModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
