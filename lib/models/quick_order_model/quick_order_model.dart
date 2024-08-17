import 'dart:convert';

class QuickOrderModel {
  final String message;
  final Data data;
  QuickOrderModel({
    required this.message,
    required this.data,
  });

  QuickOrderModel copyWith({
    String? message,
    Data? data,
  }) {
    return QuickOrderModel(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': data.toMap(),
    };
  }

  factory QuickOrderModel.fromMap(Map<String, dynamic> map) {
    return QuickOrderModel(
      message: map['message'] as String,
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuickOrderModel.fromJson(String source) =>
      QuickOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuickOrderModel(message: $message, data: $data)';

  @override
  bool operator ==(covariant QuickOrderModel other) {
    if (identical(this, other)) return true;

    return other.message == message && other.data == data;
  }

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}

class Data {
  final Order order;
  Data({
    required this.order,
  });

  Data copyWith({
    Order? order,
  }) {
    return Data(
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order': order.toMap(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      order: Order.fromMap(map['order'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(order: $order)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.order == order;
  }

  @override
  int get hashCode => order.hashCode;
}

class Order {
  final int id;
  final String orderId;
  final String scheduledDate;
  final String scheduledTime;
  final String status;
  Order({
    required this.id,
    required this.orderId,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.status,
  });

  Order copyWith({
    int? id,
    String? orderId,
    String? scheduledDate,
    String? scheduledTime,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'scheduled_date': scheduledDate,
      'scheduled_time': scheduledTime,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'].toInt() as int,
      orderId: map['order_id'] as String,
      scheduledDate: map['scheduled_date'] as String,
      scheduledTime: map['scheduled_time'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, order_id: $orderId, scheduled_date: $scheduledDate, scheduled_time: $scheduledTime, status: $status)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderId == orderId &&
        other.scheduledDate == scheduledDate &&
        other.scheduledTime == scheduledTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        scheduledDate.hashCode ^
        scheduledTime.hashCode ^
        status.hashCode;
  }
}
