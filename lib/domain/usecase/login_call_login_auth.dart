import 'package:core/core.dart';
import 'package:shax/domain/repositories/login_repository.dart';
import 'package:shax/models/request/auth_request.dart';

class LoginCallLoginAuth extends UseCase<String, AuthRequest>{

  LoginRepository repository;

  LoginCallLoginAuth({required this.repository});

  @override
  Future<Result<String>> call(AuthRequest params)async{
    return await repository.callLoginAuth(params.toMap());
  }

}
