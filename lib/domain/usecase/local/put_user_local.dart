import 'package:core/core.dart';
import '../../../models/entities/user.dart';
import '../../repositories/local/user_repository.dart';

class PutUserLocal extends UseCaseSync<bool, User>{

  UserRepository repository;

  PutUserLocal({required this.repository});

  @override
  Result<bool> call(User params){
    return repository.putUser(params);
  }

}