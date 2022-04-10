import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:shax/models/entities/init_call.dart';

abstract class SplashRemoteDatasource{
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams);
}

class SplashRemoteDatasourceImpl implements SplashRemoteDatasource{

  Dio dio;
  ShaxLogger logger;

  SplashRemoteDatasourceImpl({required this.dio, required this.logger});

  @override
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams) async {
    try {
      final _result = await dio.get(ApiConstants.fetchInitCallUrl, queryParameters: queryParams);
      return Result.success(InitCall.fromJson(_result.data["data"]));
    }catch(error){
      if(error is! DioError) {
        logger.logError("During fetchInitCall datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

}
