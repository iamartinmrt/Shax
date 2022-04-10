import 'package:core/core.dart';
import 'package:shax/domain/repositories/product_repository.dart';
import 'package:shax/models/entities/product.dart';

class ProductCallCreateProduct extends UseCase<Product, Product>{

  final ProductRepository repository;

  ProductCallCreateProduct({required this.repository});

  @override
  Future<Result<Product>> call(Product params)async{
    return await repository.createProduct(params.toJson());
  }

}