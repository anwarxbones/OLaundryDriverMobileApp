import 'dart:convert';

class ProductModel {
  final int productId;
  final String productName;
  final String soldBy;
  final String categoryName;
  final double price;
  final double? discountPrice;
  final double? discountPercentage;
  final String image;
  final List<SubProduct> subProducts;
  ProductModel({
    required this.productId,
    required this.productName,
    required this.soldBy,
    required this.categoryName,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.image,
    required this.subProducts,
  });

  ProductModel copyWith({
    int? productId,
    String? productName,
    String? soldBy,
    String? categoryName,
    double? price,
    double? discountPrice,
    double? discountPercentage,
    String? image,
    List<SubProduct>? subProducts,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      soldBy: soldBy ?? this.soldBy,
      categoryName: categoryName ?? this.categoryName,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      image: image ?? this.image,
      subProducts: subProducts ?? this.subProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'product_name': productName,
      'sold_by': soldBy,
      'category_name': categoryName,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'image_path': image,
      'sub_products': subProducts.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      soldBy: map['sold_by'] as String,
      categoryName: map['category_name'] as String,
      price: (map['price'] as num).toDouble(),
      discountPrice: map['discount_price'] != null
          ? (map['discount_price'] as num).toDouble()
          : null,
      discountPercentage: map['discount_percentage'] != null
          ? (map['discount_percentage'] as num).toDouble()
          : null,
      image: map['image_path'] as String,
      subProducts: List<SubProduct>.from(
        (map['sub_products'] as List<dynamic>).map<SubProduct>(
          (x) => SubProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SubProduct {
  final int id;
  final String name;
  final double price;
  SubProduct({
    required this.id,
    required this.name,
    required this.price,
  });

  SubProduct copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return SubProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory SubProduct.fromMap(Map<String, dynamic> map) {
    return SubProduct(
      id: map['id'] as int,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubProduct.fromJson(String source) =>
      SubProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
