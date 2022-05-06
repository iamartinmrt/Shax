import 'package:core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shax/models/entities/user.dart';

import '../../../../models/entities/app_data.dart';

abstract class UserLocalDatasource{
  Result<User> getUser();
  Result<bool> putUser(User user);
}

class UserLocalDatasourceImpl implements UserLocalDatasource{

  Box<AppData> hiveBox;
  ShaxLogger logger;

  UserLocalDatasourceImpl({required this.hiveBox, required this.logger});

  @override
  Result<User> getUser() {
    try {
      User user = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!.user;
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
      AppData appData = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!;
      AppData newAppData = appData.copyWith(user: user);
      hiveBox.put(ApiConstants.appDataInstance, newAppData);
      return Result.success(true);
    }catch(error){
      String textError = "During putUser localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

}
