import 'package:core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../models/entities/app_data.dart';

abstract class FcmLocalDatasource{
  Result<String> getToken();
  Result<bool> putToken(String fcmToken);
}

class FcmLocalDatasourceImpl implements FcmLocalDatasource{

  Box<AppData> hiveBox;
  ShaxLogger logger;

  FcmLocalDatasourceImpl({required this.hiveBox, required this.logger});

  @override
  Result<String> getToken() {
    try {
      String fcmToken = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!.fcmToken;
      return Result.success(fcmToken);
    }catch(error){
      String textError = "During getToken localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

  @override
  Result<bool> putToken(String fcmToken) {
    try{
      AppData appData = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!;
      AppData newAppData = appData.copyWith(fcmToken: fcmToken);
      hiveBox.put(ApiConstants.appDataInstance, newAppData);
      return Result.success(true);
    }catch(error){
      String textError = "During putToken localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

}
