import 'package:core/core.dart';
import 'package:shax/domain/repositories/product_repository.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/models/request/list_products_request.dart';

class ProductFetchListProducts extends UseCase<List<Product>, ListProductsRequest>{

  ProductRepository repository;

  ProductFetchListProducts({required this.repository});

  @override
  Future<Result<List<Product>>> call(ListProductsRequest params)async{
    return await repository.fetchListProducts(params.toMap());
  }

}