import 'package:core/core.dart';
import 'package:shax/domain/repositories/login_repository.dart';

class LoginCallUpdateUser extends UseCase<bool, Map<String, String>>{

  LoginRepository repository;

  LoginCallUpdateUser({required this.repository});

  @override
  Future<Result<bool>> call(Map<String, String> params)async{
    return await repository.callUpdateUser(params);
  }

}