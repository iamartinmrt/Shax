import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:shax/models/entities/product.dart';

abstract class ProductRemoteDatasource{
  Future<Result<List<Product>>> fetchListProducts(Map<String, dynamic> queryParams);
  Future<Result<bool>> callDeleteProduct(Map<String, dynamic> queryParams);
  Future<Result<Product>> createProduct(Map<String, dynamic> body);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource{

  Dio dio;
  ShaxLogger logger;


  ProductRemoteDatasourceImpl({required this.dio, required this.logger});

  @override
  Future<Result<List<Product>>> fetchListProducts(Map<String, dynamic> queryParams)async{
    try {
      final _result = await dio.get(ApiConstants.fetchListProductsUrl, queryParameters: queryParams);
      return Result.success((_result.data["data"] as List<dynamic>).map((e) =>
          Product.fromJson(e as Map<String, dynamic>)).toList());
    }catch(error){
      if(error is! DioError) {
        logger.logError("During fetchInitCall datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

  @override
  Future<Result<bool>> callDeleteProduct(Map<String, dynamic> queryParams)async{
    try{
      final _result = await dio.delete(ApiConstants.callDeleteProductUrl, queryParameters: queryParams);
      return Result.success(true);
    }catch(error){
      if(error is! DioError) {
        logger.logError("During fetchInitCall datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

  @override
  Future<Result<Product>> createProduct(Map<String, dynamic> body)async{
    try{
      final _result = await dio.post(ApiConstants.callCreateProductUrl, data: body);
      return Result.success(Product.fromJson(_result.data["data"]));
    }catch(error){
      if(error is! DioError) {
        logger.logError("During fetchInitCall datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

}
