import 'dart:convert';

import 'data.dart';

class ThisWeekDeliveryModel {
  String? message;
  Data? data;

  ThisWeekDeliveryModel({this.message, this.data});

  factory ThisWeekDeliveryModel.fromMap(Map<String, dynamic> data) {
    return ThisWeekDeliveryModel(
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
  /// Parses the string and returns the resulting Json object as [ThisWeekDeliveryModel].
  factory ThisWeekDeliveryModel.fromJson(String data) {
    return ThisWeekDeliveryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ThisWeekDeliveryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
