import 'dart:convert';

import 'data.dart';

class PendingOrderListModel {
  String? message;
  Data? data;

  PendingOrderListModel({this.message, this.data});

  factory PendingOrderListModel.fromMap(Map<String, dynamic> data) {
    return PendingOrderListModel(
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
  /// Parses the string and returns the resulting Json object as [PendingOrderListModel].
  factory PendingOrderListModel.fromJson(String data) {
    return PendingOrderListModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PendingOrderListModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
