import 'package:core/core.dart';
import 'package:shax/domain/repositories/product_repository.dart';

class ProductCallDeleteProduct extends UseCase<bool, String>{

  ProductRepository repository;

  ProductCallDeleteProduct({required this.repository});

  @override
  Future<Result<bool>> call(String params)async{
    return await repository.callDeleteProduct(<String, dynamic>{"id": params});
  }

}