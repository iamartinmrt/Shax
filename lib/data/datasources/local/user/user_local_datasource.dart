import 'package:core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shax/models/entities/user.dart';

abstract class UserLocalDatasource{
  Result<User> getUser();
  Result<bool> putUser(User user);
}

class UserLocalDatasourceImpl implements UserLocalDatasource{

  Box<User> hiveBox;
  ShaxLogger logger;

  UserLocalDatasourceImpl({required this.hiveBox, required this.logger});

  @override
  Result<User> getUser() {
    try {
      User user = hiveBox.get(ApiConstants.userInstance, defaultValue: const User(email: "", id: "", token: ""))!;
      return Result.success(user);
    }catch(error){
      String textError = "During getUser localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

  @override
  Result<bool> putUser(User user) {
    try{
      hiveBox.put(ApiConstants.userInstance, user);
      return Result.success(true);
    }catch(error){
      String textError = "During putUser localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

}
