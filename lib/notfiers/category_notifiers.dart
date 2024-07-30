import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/repos/category_repo.dart';
import 'package:laundry_customer/services/api_state.dart';
import 'package:laundry_customer/services/network_exceptions.dart';

class CategoryNotifier extends StateNotifier<ApiState<List<CategoryModel>>> {
  CategoryNotifier(this.repo) : super(const ApiState.initial()) {
    fatchCategory();
  }
  final ICategoryRepo repo;

  Future<void> fatchCategory() async {
    state = const ApiState.loading();
    try {
      state = ApiState.loaded(data: await repo.fatchCategory());
    } catch (e) {
      state = ApiState.error(error: NetworkExceptions.errorText(e));
    }
  }
}
