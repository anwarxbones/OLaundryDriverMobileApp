import 'package:hive_flutter/hive_flutter.dart';
import 'package:laundry_customer/constants/hive_contants.dart';
import 'package:laundry_customer/models/cart/cart_model.dart';

class LocalService {
  static final LocalService _localService = LocalService._internal();
  factory LocalService() {
    return _localService;
  }
  LocalService._internal();

  Future<void> addToCart({required CartModel cartModel}) async {
    final box = Hive.box<CartModel>(AppHSC.cartBox);
    await box.put(cartModel.productId, cartModel);
  }

  Future<void> removeFromCart({required int productId}) async {
    final box = Hive.box<CartModel>(AppHSC.cartBox);
    await box.delete(productId);
  }

  Future<void> incrementQuantity({required int productId}) async {
    final box = Hive.box<CartModel>(AppHSC.cartBox);
    final CartModel? cartModel = box.get(productId);
    if (cartModel != null) {
      await box.put(
        productId,
        cartModel.copyWith(quantity: cartModel.quantity + 1),
      );
    }
  }

  Future<void> decrementQuantity({required int productId}) async {
    final box = Hive.box<CartModel>(AppHSC.cartBox);
    final CartModel? cartModel = box.get(productId);
    if (cartModel?.quantity == 1) {
      await box.delete(productId);
    } else {
      if (cartModel != null) {
        await box.put(
          productId,
          cartModel.copyWith(quantity: cartModel.quantity - 1),
        );
      }
    }
  }

  List<CartModel> getCart() {
    final box = Hive.box<CartModel>(AppHSC.cartBox);
    return box.values.toList();
  }

  double calculateTotal({required List<CartModel> cartItems}) {
    double amount = 0;
    for (final item in cartItems) {
      amount += item.quantity * item.price!;
      if (item.addOns.isNotEmpty) {
        for (final addOn in item.addOns) {
          amount += addOn.price;
        }
      }
    }
    return amount;
  }
}
