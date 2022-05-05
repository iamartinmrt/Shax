import 'package:core/core.dart';
import 'package:shax/domain/repositories/local/user_repository.dart';
import '../../../models/entities/user.dart';
import '../../../models/request/no_param_request.dart';

class GetUserLocal extends UseCaseSync<User, NoParamRequest>{

  UserRepository repository;

  GetUserLocal({required this.repository});

  @override
  Result<User> call(NoParamRequest params){
    return repository.getUser();
  }

}