import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/notfiers/category_notifiers.dart';
import 'package:laundry_customer/repos/category_repo.dart';
import 'package:laundry_customer/services/api_state.dart';

final categoryRepoProvider = Provider<ICategoryRepo>((ref) {
  return CategoryRepo();
});

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, ApiState<List<CategoryModel>>>(
  (ref) {
    return CategoryNotifier(
      ref.watch(categoryRepoProvider),
    );
  },
);
