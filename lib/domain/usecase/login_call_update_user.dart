import 'package:core/core.dart';
import 'package:shax/domain/repositories/login_repository.dart';
import 'dart:io';

class LoginCallUpdateUser extends UseCase<bool, String>{

  LoginRepository repository;

  LoginCallUpdateUser({required this.repository});

  @override
  Future<Result<bool>> call(String params)async{
    Map<String, String> map;
    if(Platform.isAndroid){
      map = <String, String>{
        "fb_token_android": params,
      };
    }else {
      map = <String, String>{
        "fb_token_ios": params,
      };
    }
    return await repository.callUpdateUser(map);
  }

}