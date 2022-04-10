import 'package:core/core.dart';
import 'package:shax/domain/repositories/signup_repository.dart';
import 'package:shax/models/request/auth_request.dart';

class SignupCallSignupAuth extends UseCase<bool, AuthRequest>{

  SignupRepository repository;

  SignupCallSignupAuth({required this.repository});

  @override
  Future<Result<bool>> call(AuthRequest params)async{
    return await repository.callSignupAuth(params.toMap());
  }

}
