import 'dart:convert';

class Status {
  String? lable;
  String? value;

  Status({this.lable, this.value});

  factory Status.fromMap(Map<String, dynamic> data) => Status(
        lable: data['lable'] as String?,
        value: data['value'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'lable': lable,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Status].
  factory Status.fromJson(String data) {
    return Status.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Status] to a JSON string.
  String toJson() => json.encode(toMap());
}
