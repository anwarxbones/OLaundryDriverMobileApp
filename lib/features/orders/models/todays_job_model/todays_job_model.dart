import 'dart:convert';

import 'data.dart';

class TodaysJobModel {
  String? message;
  Data? data;

  TodaysJobModel({this.message, this.data});

  factory TodaysJobModel.fromMap(Map<String, dynamic> data) {
    return TodaysJobModel(
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
  /// Parses the string and returns the resulting Json object as [TodaysJobModel].
  factory TodaysJobModel.fromJson(String data) {
    return TodaysJobModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TodaysJobModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
