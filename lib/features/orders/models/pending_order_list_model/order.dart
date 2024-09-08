import 'dart:convert';

import 'address.dart';
import 'customer.dart';
import 'product.dart';
import 'quantity.dart';

class Order {
  int? id;
  String? orderCode;
  Customer? customer;
  String? driverStatus;
  double? discount;
  double? amount;
  double? totalAmount;
  int? deliveryCharge;
  String? orderStatus;
  String? paymentStatus;
  String? paymentType;
  String? pickDate;
  String? pickHour;
  String? deliveryDate;
  String? deliveryHour;
  String? orderedAt;
  int? rating;
  int? item;
  Address? address;
  List<Product>? products;
  Quantity? quantity;
  dynamic payment;
  String? pickAndDelivaryStatus;
  bool? isTypePickup;
  String? customerName;
  String? phone;
  String? instruction;

  Order({
    this.id,
    this.orderCode,
    this.driverStatus,
    this.customer,
    this.discount,
    this.amount,
    this.totalAmount,
    this.deliveryCharge,
    this.orderStatus,
    this.paymentStatus,
    this.paymentType,
    this.pickDate,
    this.pickHour,
    this.deliveryDate,
    this.deliveryHour,
    this.orderedAt,
    this.rating,
    this.item,
    this.address,
    this.products,
    this.quantity,
    this.payment,
    this.pickAndDelivaryStatus,
    this.isTypePickup,
    this.customerName,
    this.phone,
    this.instruction,
  });

  factory Order.fromMap(Map<String, dynamic> data) => Order(
        id: data['id'] as int?,
        orderCode: data['order_code'] as String?,
        driverStatus: data['driver_status'] as String?,
        customer: data['customer'] == null
            ? null
            : Customer.fromMap(data['customer'] as Map<String, dynamic>),
        discount: (data['discount'] as num?)?.toDouble(),
        amount: (data['amount'] as num?)?.toDouble(),
        totalAmount: (data['total_amount'] as num?)?.toDouble(),
        deliveryCharge: data['delivery_charge'] as int?,
        orderStatus: data['status'] as String?,
        paymentStatus: data['payment_status'] as String?,
        paymentType: data['payment_type'] as String?,
        pickDate: data['pick_date'] as String?,
        pickHour: data['pick_hour'] as String?,
        deliveryDate: data['delivery_date'] as String?,
        deliveryHour: data['delivery_hour'] as String?,
        orderedAt: data['ordered_at'] as String?,
        rating: data['rating'] as int?,
        item: data['item'] as int?,
        address: data['address'] == null
            ? null
            : Address.fromMap(data['address'] as Map<String, dynamic>),
        products: (data['products'] as List<dynamic>?)
            ?.map((e) => Product.fromMap(e as Map<String, dynamic>))
            .toList(),
        quantity: data['quantity'] == null
            ? null
            : Quantity.fromMap(data['quantity'] as Map<String, dynamic>),
        payment: data['payment'] as dynamic,
        pickAndDelivaryStatus: data['pickanddelivary_status'] as String?,
        isTypePickup: data['is_type_pickup'] as bool?,
        customerName: data['customer_name'] as String?,
        phone: data['phone'] as String?,
        instruction: data['instructions'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'order_code': orderCode,
        'driver_status': driverStatus,
        'customer': customer?.toMap(),
        'discount': discount,
        'amount': amount,
        'total_amount': totalAmount,
        'delivery_charge': deliveryCharge,
        'order_status': orderStatus,
        'payment_status': paymentStatus,
        'payment_type': paymentType,
        'pick_date': pickDate,
        'pick_hour': pickHour,
        'delivery_date': deliveryDate,
        'delivery_hour': deliveryHour,
        'ordered_at': orderedAt,
        'rating': rating,
        'item': item,
        'address': address?.toMap(),
        'products': products?.map((e) => e.toMap()).toList(),
        'quantity': quantity?.toMap(),
        'payment': payment,
        'pickanddelivary_status': pickAndDelivaryStatus,
        'is_type_pickup': isTypePickup,
        'customer_name': customerName,
        'phone': phone,
        'instruction': instruction,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());
}
