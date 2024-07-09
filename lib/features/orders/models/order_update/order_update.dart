import 'dart:convert';

import 'data.dart';

class OrderUpdate {
  String? message;
  Data? data;

  OrderUpdate({this.message, this.data});

  factory OrderUpdate.fromMap(Map<String, dynamic> data) => OrderUpdate(
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderUpdate].
  factory OrderUpdate.fromJson(String data) {
    return OrderUpdate.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderUpdate] to a JSON string.
  String toJson() => json.encode(toMap());
}
