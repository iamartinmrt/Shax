import 'package:core/core.dart';
import 'package:shax/domain/repositories/splash_repository.dart';
import 'package:shax/models/entities/init_call.dart';

class SplashFetchInitCall implements UseCase<InitCall, String>{

  SplashRepository repository;

  SplashFetchInitCall({required this.repository});

  @override
  Future<Result<InitCall>> call(String params)async{
    Map<String, dynamic> queryParams = <String, dynamic>{
      "app_version": params,
    };
    return await repository.fetchInitCall(queryParams);
  }

}
