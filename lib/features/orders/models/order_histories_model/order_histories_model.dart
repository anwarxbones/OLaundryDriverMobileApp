import 'dart:convert';

import 'data.dart';

class OrderHistoriesModel {
  String? message;
  Data? data;

  OrderHistoriesModel({this.message, this.data});

  factory OrderHistoriesModel.fromMap(Map<String, dynamic> data) {
    return OrderHistoriesModel(
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
  /// Parses the string and returns the resulting Json object as [OrderHistoriesModel].
  factory OrderHistoriesModel.fromJson(String data) {
    return OrderHistoriesModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderHistoriesModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
