import 'dart:convert';

class Notification {
  int? id;
  String? message;
  int? isRead;

  Notification({this.id, this.message, this.isRead});

  factory Notification.fromMap(Map<String, dynamic> data) => Notification(
        id: data['id'] as int?,
        message: data['message'] as String?,
        isRead: data['isRead'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'message': message,
        'isRead': isRead,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Notification].
  factory Notification.fromJson(String data) {
    return Notification.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Notification] to a JSON string.
  String toJson() => json.encode(toMap());
}
