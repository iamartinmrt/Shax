import 'dart:convert';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import '../../../../../models/entities/user.dart';


abstract class LoginRemoteDatasource{
  Future<Result<User>> callLoginAuth(Map<String, dynamic> queryParams);
  Future<Result<bool>> callUpdateUser(Map<String, String> body);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource{

  Dio dio;
  ShaxLogger logger;

  LoginRemoteDatasourceImpl({required this.dio, required this.logger});

  @override
  Future<Result<User>> callLoginAuth(Map<String, dynamic> body)async{
    try {
      final _result = await dio.post(ApiConstants.callLoginAuthUrl, data: body);
      final response = User.fromJson(_result.data["data"]);
      return Result.success(response);
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
