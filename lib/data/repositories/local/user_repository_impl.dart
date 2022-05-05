import 'package:core/src/utils/result.dart';
import 'package:shax/data/datasources/local/user/user_local_datasource.dart';
import 'package:shax/domain/repositories/local/user_repository.dart';
import 'package:shax/models/entities/user.dart';

class UserRepositoryImpl implements UserRepository{

  UserLocalDatasource datasource;

  UserRepositoryImpl({required this.datasource});

  @override
  Result<User> getUser() {
    return datasource.getUser();
  }

  @override
  Result<bool> putUser(User user) {
    return datasource.putUser(user);
  }

}