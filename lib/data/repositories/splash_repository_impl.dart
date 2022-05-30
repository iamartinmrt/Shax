import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:shax/data/datasources/mock_generator/splash/splash_mock_generator.dart';
import 'package:shax/data/datasources/remote/splash/splash_remote_datasource.dart';
import 'package:shax/domain/repositories/splash_repository.dart';
import 'package:shax/models/entities/init_call.dart';

class SplashRepositoryImpl implements SplashRepository{

  SplashRemoteDatasource datasource;
  MockDataGenerator mockDataGenerator;

  SplashRepositoryImpl({required this.datasource, required this.mockDataGenerator});

  @override
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return mockDataGenerator.fetchInitialCall(SplashTestCase.authorized);
    }
    return datasource.fetchInitCall(queryParams);
  }

}