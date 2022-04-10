import 'package:core/core.dart';
import 'package:shax/data/datasources/remote/splash/splash_remote_datasource.dart';
import 'package:shax/domain/repositories/splash_repository.dart';
import 'package:shax/models/entities/init_call.dart';

class SplashRepositoryImpl implements SplashRepository{

  SplashRemoteDatasource datasource;

  SplashRepositoryImpl({required this.datasource});

  @override
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams) async {
    return datasource.fetchInitCall(queryParams);
  }

}