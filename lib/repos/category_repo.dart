import 'package:dio/dio.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/services/api_service.dart';

abstract class ICategoryRepo {
  Future<List<CategoryModel>> fatchCategory();
}

class CategoryRepo extends ICategoryRepo {
  final Dio _dio = getDio();
  @override
  Future<List<CategoryModel>> fatchCategory() async {
    final Response response = await _dio.get(
      '/categories',
    );

    if (response.statusCode == 200) {
      return (response.data['data']['productcats'] as List)
          .map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
