import 'package:core/src/utils/result.dart';
import 'package:shax/data/datasources/remote/authentication/login/login_remote_datasource.dart';
import 'package:shax/domain/repositories/login_repository.dart';
import '../../models/entities/user.dart';

class LoginRepositoryImpl implements LoginRepository{

  LoginRemoteDatasource datasource;

  LoginRepositoryImpl({required this.datasource});

  @override
  Future<Result<User>> callLoginAuth(Map<String, dynamic> body)async{
    return await datasource.callLoginAuth(body);
  }

  @override
  Future<Result<bool>> callUpdateUser(Map<String, String> body)async{
    return await datasource.callUpdateUser(body);
  }

}