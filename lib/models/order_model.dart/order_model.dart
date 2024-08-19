import 'package:laundry_customer/models/addres_list_model/address.dart';
import 'package:laundry_customer/models/profile_info_model/user.dart';

class AllOrderModels {
  final String message;
  final OrderData data;

  AllOrderModels({required this.message, required this.data});

  factory AllOrderModels.fromJson(Map<String, dynamic> json) {
    return AllOrderModels(
      message: json['message'] as String,
      data: OrderData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class OrderData {
  final List<Order> orders;

  OrderData({required this.orders});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    final ordersList = json['orders'] as List;
    final List<Order> orders = ordersList
        .map((i) => Order.fromJson(i as Map<String, dynamic>))
        .toList();

    return OrderData(orders: orders);
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}

class Order {
  final int id;
  final String orderCode;
  final double discount;
  final double amount;
  final double totalAmount;
  final double deliveryCharge;
  final String orderStatus;
  final String paymentStatus;
  final String paymentType;
  final String pickDate;
  final String? pickHour;
  final String deliveryDate;
  final String deliveryHour;
  final String orderedAt;
  final int item;
  final User customer;
  final List<Product> products;
  final String? payment;
  final String? paymentUrl;
  final Address address;

  Order({
    required this.id,
    required this.orderCode,
    required this.discount,
    required this.amount,
    required this.totalAmount,
    required this.deliveryCharge,
    required this.orderStatus,
    required this.paymentStatus,
    required this.paymentType,
    required this.pickDate,
    required this.pickHour,
    required this.deliveryDate,
    required this.deliveryHour,
    required this.orderedAt,
    required this.item,
    required this.customer,
    required this.address,
    required this.products,
    required this.payment,
    required this.paymentUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final productsList = json['products'] as List;
    final List<Product> products = productsList
        .map((i) => Product.fromJson(i as Map<String, dynamic>))
        .toList();

    return Order(
      id: json['id'] as int,
      orderCode: json['order_code'] as String,
      discount: json['discount'].toDouble() as double,
      amount: json['amount'].toDouble() as double,
      totalAmount: json['total_amount'].toDouble() as double,
      deliveryCharge: json['delivery_charge'].toDouble() as double,
      orderStatus: json['order_status'] as String,
      paymentStatus: json['payment_status'] as String,
      paymentType: json['payment_type'] as String,
      pickDate: json['pick_date'] as String,
      pickHour: json['pick_hour'] as String?,
      deliveryDate: json['delivery_date'] as String,
      deliveryHour: json['delivery_hour'] as String,
      orderedAt: json['ordered_at'] as String,
      item: json['item'] as int,
      customer: User.fromMap(json['customer'] as Map<String, dynamic>),
      address: Address.fromMap(json['address'] as Map<String, dynamic>),
      products: products,
      payment: json['payment'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
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
      'item': item,
      'customer': customer.toMap(),
      'address': address.toMap(),
      'products': products.map((product) => product.toJson()).toList(),
      'payment': payment,
      'payment_url': paymentUrl,
    };
  }
}

class Product {
  final int productId;
  final String categoryName;
  final String productName;
  final String soldBy;
  final double price;
  final double previousPrice;
  final double discountPrice;
  final dynamic discountPercentage;
  final int quantity;
  final String imagePath;
  final List<SubProduct> subProducts;
  final String? additionalNotes;

  Product({
    required this.productId,
    required this.categoryName,
    required this.productName,
    required this.soldBy,
    required this.price,
    required this.previousPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.quantity,
    required this.imagePath,
    required this.subProducts,
    this.additionalNotes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final subProductsList = json['sub_products'] as List;
    final List<SubProduct> subProducts = subProductsList
        .map((i) => SubProduct.fromJson(i as Map<String, dynamic>))
        .toList();

    return Product(
      productId: json['product_id'] as int,
      categoryName: json['category_name'] as String,
      productName: json['product_name'] as String,
      soldBy: json['sold_by'] as String,
      price: json['price'].toDouble() as double,
      previousPrice: json['previous_price'].toDouble() as double,
      discountPrice: json['discount_price'].toDouble() as double,
      discountPercentage: json['discount_percentage'],
      quantity: json['quantity'] as int,
      imagePath: json['image_path'] as String,
      subProducts: subProducts,
      additionalNotes: json['additional_notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'category_name': categoryName,
      'product_name': productName,
      'sold_by': soldBy,
      'price': price,
      'previous_price': previousPrice,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'quantity': quantity,
      'image_path': imagePath,
      'sub_products':
          subProducts.map((subProduct) => subProduct.toJson()).toList(),
      'additional_notes': additionalNotes,
    };
  }
}

class SubProduct {
  final int id;
  final String name;
  final double price;

  SubProduct({required this.id, required this.name, required this.price});

  factory SubProduct.fromJson(Map<String, dynamic> json) {
    return SubProduct(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'].toDouble() as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
