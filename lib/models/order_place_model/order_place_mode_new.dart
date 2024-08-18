import 'dart:convert';

class OrderPlaceModelNew {
  final String pickDate;
  final String pickHour;
  final String deliveryDate;
  final String deliveryHour;
  final String addressId;
  final String? couponId;
  final String? instruction;
  final List<Product> products;
  final List<int> subProductIds;
  OrderPlaceModelNew({
    required this.pickDate,
    required this.pickHour,
    required this.deliveryDate,
    required this.deliveryHour,
    required this.addressId,
    this.couponId,
    this.instruction,
    required this.products,
    required this.subProductIds,
  });

  OrderPlaceModelNew copyWith({
    String? pickDate,
    String? pickHour,
    String? deliveryDate,
    String? deliveryHour,
    String? addressId,
    String? couponId,
    String? instruction,
    List<Product>? products,
    List<int>? subProductIds,
  }) {
    return OrderPlaceModelNew(
      pickDate: pickDate ?? this.pickDate,
      pickHour: pickHour ?? this.pickHour,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryHour: deliveryHour ?? this.deliveryHour,
      addressId: addressId ?? this.addressId,
      couponId: couponId ?? this.couponId,
      instruction: instruction ?? this.instruction,
      products: products ?? this.products,
      subProductIds: subProductIds ?? this.subProductIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pick_date': pickDate,
      'pick_hour': pickHour,
      'delivery_date': deliveryDate,
      'delivery_hour': deliveryHour,
      'address_id': addressId,
      'coupon_id': couponId,
      'instruction': instruction,
      'products': products.map((x) => x.toMap()).toList(),
      'sub_product_id': subProductIds,
    };
  }

  factory OrderPlaceModelNew.fromMap(Map<String, dynamic> map) {
    return OrderPlaceModelNew(
      pickDate: map['pick_date'] as String,
      pickHour: map['pick_hour'] as String,
      deliveryDate: map['delivery_date'] as String,
      deliveryHour: map['delivery_hour'] as String,
      addressId: map['address_id'] as String,
      couponId: map['coupon_id'] != null ? map['coupon_id'] as String : null,
      instruction:
          map['instruction'] != null ? map['instruction'] as String : null,
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      subProductIds: List<int>.from(
        map['sub_product_id'] as List<int>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPlaceModelNew.fromJson(String source) =>
      OrderPlaceModelNew.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  final int productId;
  final double quantity;
  final String? instrunction;
  Product({
    required this.productId,
    required this.quantity,
    this.instrunction,
  });

  Product copyWith({
    int? productId,
    double? quantity,
    String? instrunction,
  }) {
    return Product(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      instrunction: instrunction ?? instrunction,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': productId,
      'quantity': quantity,
      'instruction': instrunction,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['product_id'] as int,
      quantity: map['quantity'] as double,
      instrunction:
          map['instruction'] != null ? map['instruction'] as String : null,
    );
  }
}
