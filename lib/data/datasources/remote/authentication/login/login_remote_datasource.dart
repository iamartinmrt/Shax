import 'dart:convert';
import 'package:core/core.dart';
import 'package:dio/dio.dart';


abstract class LoginRemoteDatasource{
  Future<Result<String>> callLoginAuth(Map<String, dynamic> queryParams);
  Future<Result<bool>> callUpdateUser(Map<String, String> body);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource{

  Dio dio;
  ShaxLogger logger;

  LoginRemoteDatasourceImpl({required this.dio, required this.logger});

  @override
  Future<Result<String>> callLoginAuth(Map<String, dynamic> body)async{
    try {
      final _result = await dio.post(ApiConstants.callLoginAuthUrl, data: body);
      return Result.success(_result.data["data"]);
    }catch(error){
      if(error is! DioError) {
        logger.logError("During callLoginAuth datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

  @override
  Future<Result<bool>> callUpdateUser(Map<String, String> body)async{
    try {
      final _result = await dio.put(ApiConstants.callUpdateUserUrl, data: body);
      return Result.success(_result.data["data"]);
    }catch(error){
      if(error is! DioError) {
        logger.logError("During callUpdateUser datasource\nError: ${error.toString()}");
      }
      return Result.error(error.toString());
    }
  }

}
