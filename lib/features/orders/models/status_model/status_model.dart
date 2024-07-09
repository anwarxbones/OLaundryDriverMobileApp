import 'dart:convert';

import 'data.dart';

class StatusModel {
  String? message;
  Data? data;

  StatusModel({this.message, this.data});

  factory StatusModel.fromMap(Map<String, dynamic> data) => StatusModel(
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
  /// Parses the string and returns the resulting Json object as [StatusModel].
  factory StatusModel.fromJson(String data) {
    return StatusModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StatusModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
