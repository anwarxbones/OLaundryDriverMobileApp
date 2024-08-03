import 'package:hive/hive.dart';
import 'package:laundry_customer/models/cart/add_ons_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final double quantity;

  @HiveField(2)
  final List<AddOns> addOns;

  @HiveField(3)
  final String? note;

  @HiveField(4)
  final double? price;

  @HiveField(5)
  final double? discountPrice;

  @HiveField(6)
  final double? discountPercentage;

  @HiveField(7)
  final String name;

  @HiveField(8)
  final String image;

  @HiveField(9)
  final String categoryName;

  @HiveField(10)
  final String soldBy;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.addOns,
    required this.price,
    this.note,
    this.discountPrice,
    this.discountPercentage,
    required this.name,
    required this.image,
    required this.categoryName,
    required this.soldBy,
  });

  CartModel copyWith({
    int? productId,
    double? quantity,
    List<AddOns>? addOns,
    double? price,
    String? note,
    double? discountPrice,
    double? discountPercentage,
    String? name,
    String? image,
    String? categoryName,
    String? soldBy,
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      addOns: addOns ?? this.addOns,
      price: price ?? this.price,
      note: note ?? this.note,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      name: name ?? this.name,
      image: image ?? this.image,
      categoryName: categoryName ?? this.categoryName,
      soldBy: soldBy ?? this.soldBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'add_ons': addOns.map((addon) => addon.toMap()).toList(),
      'note': note,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'name': name,
      'image': image,
      'category_name': categoryName,
      'sold_by': soldBy,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['product_id'] as int,
      quantity: map['quantity'] as double,
      addOns: map['add_ons'] != null
          ? List<AddOns>.from(
              (map['add_ons'] as List<dynamic>).map<AddOns>(
                (x) => AddOns.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      price: map['price'] != null ? map['price'] as double : null,
      note: map['note'] != null ? map['note'] as String : null,
      discountPrice: map['discount_price'] != null
          ? map['discount_price'] as double
          : null,
      discountPercentage: map['discount_percentage'] != null
          ? map['discount_percentage'] as double
          : null,
      name: map['name'] as String,
      image: map['image'] as String,
      categoryName: map['category_name'] as String,
      soldBy: map['sold_by'] as String,
    );
  }
}
