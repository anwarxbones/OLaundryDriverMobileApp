import 'dart:convert';

class TotalCout {
  final int pending;
  final int accepted;
  final int completed;
  TotalCout({
    required this.pending,
    required this.accepted,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pending': pending,
      'accepted': accepted,
      'completed': completed,
    };
  }

  factory TotalCout.fromMap(Map<String, dynamic> map) {
    return TotalCout(
      pending: map['pending'] as int,
      accepted: map['accepted'] as int,
      completed: map['completed'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalCout.fromJson(String source) =>
      TotalCout.fromMap(json.decode(source) as Map<String, dynamic>);
}
