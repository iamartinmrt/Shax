import 'package:core/core.dart';
import 'package:shax/data/datasources/remote/authentication/signup/signup_remote_datasource.dart';
import 'package:shax/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository{

  SignupRemoteDatasource datasource;

  SignupRepositoryImpl({required this.datasource});

  @override
  Future<Result<bool>> callSignupAuth(Map<String, dynamic> body)async{
    return await datasource.callSignupAuth(body);
  }

}