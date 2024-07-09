import 'dart:convert';

import 'data.dart';

class ThisWeeksDeilveryModel {
  String? message;
  Data? data;

  ThisWeeksDeilveryModel({this.message, this.data});

  factory ThisWeeksDeilveryModel.fromMap(Map<String, dynamic> data) {
    return ThisWeeksDeilveryModel(
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
  /// Parses the string and returns the resulting Json object as [ThisWeeksDeilveryModel].
  factory ThisWeeksDeilveryModel.fromJson(String data) {
    return ThisWeeksDeilveryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ThisWeeksDeilveryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
