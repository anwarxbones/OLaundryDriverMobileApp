import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/notfiers/product_notifiers.dart';
import 'package:laundry_customer/repos/product_repo.dart';
import 'package:laundry_customer/services/api_state.dart';

final productRepoProvider = Provider<IProductRepo>((ref) {
  return ProductRepo();
});

final productProvider = StateNotifierProvider.family<ProductyNotifier,
    ApiState<List<ProductModel>>, int>(
  (ref, categoryId) {
    return ProductyNotifier(
      ref.watch(productRepoProvider),
      categoryId,
    );
  },
);
