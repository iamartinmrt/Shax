import 'package:core/src/utils/result.dart';
import 'package:shax/data/datasources/remote/product/product_remote_datasource.dart';
import 'package:shax/domain/repositories/product_repository.dart';
import 'package:shax/models/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository{

  final ProductRemoteDatasource datasource;


  ProductRepositoryImpl({required this.datasource});

  @override
  Future<Result<bool>> callDeleteProduct(Map<String, dynamic> queryParams)async{
    return await datasource.callDeleteProduct(queryParams);
  }

  @override
  Future<Result<Product>> createProduct(Map<String, dynamic> body)async{
    return await datasource.createProduct(body);
  }

  @override
  Future<Result<List<Product>>> fetchListProducts(Map<String, dynamic> queryParams)async{
    return await datasource.fetchListProducts(queryParams);
  }

}