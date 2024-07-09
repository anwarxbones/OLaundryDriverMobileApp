import 'dart:convert';

import 'data.dart';

class TotalOrders {
  String? message;
  Data? data;

  TotalOrders({this.message, this.data});

  factory TotalOrders.fromMap(Map<String, dynamic> data) => TotalOrders(
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
  /// Parses the string and returns the resulting Json object as [TotalOrders].
  factory TotalOrders.fromJson(String data) {
    return TotalOrders.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TotalOrders] to a JSON string.
  String toJson() => json.encode(toMap());
}
