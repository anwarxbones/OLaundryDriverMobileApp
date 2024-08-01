import 'package:dio/dio.dart';
import 'package:laundry_customer/models/product/product_mode.dart';
import 'package:laundry_customer/services/api_service.dart';

abstract class IProductRepo {
  Future<List<ProductModel>> fatchProducts({required int? categoryId});
}

class ProductRepo extends IProductRepo {
  final Dio _dio = getDio();
  @override
  Future<List<ProductModel>> fatchProducts({required int? categoryId}) async {
    final Response response = await _dio.get(
      '/products',
      queryParameters: {
        'category_id': categoryId,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;

      final List<dynamic> products = data['products'] as List<dynamic>;

      return products
          .map((e) => ProductModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
