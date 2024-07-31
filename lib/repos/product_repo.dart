import 'package:dio/dio.dart';
import 'package:laundry_customer/models/category_model/category.dart';
import 'package:laundry_customer/services/api_service.dart';

abstract class IProductRepo {
  Future<List<CategoryModel>> fatchProducts({required int? categoryId});
}

class ProductRepo extends IProductRepo {
  final Dio _dio = getDio();
  @override
  Future<List<CategoryModel>> fatchProducts({required int? categoryId}) async {
    final Response response = await _dio.get(
      '/products',
      queryParameters: {
        'category_id': categoryId,
      },
    );

    if (response.statusCode == 200) {
      return (response.data['data']['productcats'] as List)
          .map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
