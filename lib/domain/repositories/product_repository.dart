import 'package:core/core.dart';
import 'package:shax/models/entities/product.dart';

/// An interface to represent a repository that handle product APIs
abstract class ProductRepository{
  /// Fetch list products by page number
  Future<Result<List<Product>>> fetchListProducts(Map<String, dynamic> queryParams);

  /// Delete a product with [Product.id]
  Future<Result<bool>> callDeleteProduct(Map<String, dynamic> queryParams);

  /// Create new product
  /// Receive: [Product]
  /// Return: [Product] - after create product in back-end, return product with new [Product.id]
  Future<Result<Product>> createProduct(Map<String, dynamic> body);
}