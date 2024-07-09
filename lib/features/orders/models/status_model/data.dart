import 'dart:convert';

import 'status.dart';

class Data {
  List<Status>? status;

  Data({this.status});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        status: (data['status'] as List<dynamic>?)
            ?.map((e) => Status.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
