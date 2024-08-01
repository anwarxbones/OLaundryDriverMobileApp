import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final int quantity;

  @HiveField(2)
  final List<int> addOns;

  @HiveField(3)
  final String? note;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.addOns,
    this.note,
  });

  CartModel copyWith({
    int? productId,
    int? quantity,
    List<int>? addOns,
    String? note,
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      addOns: addOns ?? this.addOns,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'add_ons': addOns,
      'note': note,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      addOns: List<int>.from(map['add_ons'] as List<int>),
      note: map['note'] != null ? map['note'] as String : null,
    );
  }
}
