import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart';

abstract class SignupRemoteDatasource{
  Future<Result<bool>> callSignupAuth(Map<String, dynamic> body);
}

class SignupRemoteDatasourceImpl implements SignupRemoteDatasource{

  Dio dio;
  ShaxLogger logger;

  SignupRemoteDatasourceImpl({required this.dio, required this.logger});

  @override
  Future<Result<bool>> callSignupAuth(Map<String, dynamic> body)async{
    try{
      final _result = await dio.post(ApiConstants.callSignupAuthUrl, data: body);
      return Result.success(true);
      // return Result.success(_result.data["data"]);
    }catch(error){
      if(error is! DioError) {
        logger.logError("During callSignupAuth datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

}
