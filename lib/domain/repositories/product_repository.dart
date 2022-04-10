import 'package:core/core.dart';
import 'package:shax/models/entities/product.dart';

abstract class ProductRepository{
  Future<Result<List<Product>>> fetchListProducts(Map<String, dynamic> queryParams);
  Future<Result<bool>> callDeleteProduct(Map<String, dynamic> queryParams);
  Future<Result<Product>> createProduct(Map<String, dynamic> body);
}