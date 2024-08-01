import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/repos/product_repo.dart';
import 'package:laundry_customer/services/api_state.dart';
import 'package:laundry_customer/services/network_exceptions.dart';

class ProductyNotifier extends StateNotifier<ApiState<List<ProductModel>>> {
  ProductyNotifier(this.repo, this.categoryId)
      : super(const ApiState.initial()) {
    fatchProducts();
  }
  final IProductRepo repo;
  final int? categoryId;
  Future<void> fatchProducts() async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(
        data: await repo.fatchProducts(categoryId: categoryId),
      );
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
