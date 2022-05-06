import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../models/entities/app_data.dart';
import '../../../../models/entities/custom_theme_mode.dart';

abstract class ThemeModeLocalDatasource{
  Result<ThemeMode> getThemeMode();
  Result<bool> putThemeMode(ThemeMode themeMode);
}

class ThemeModeLocalDatasourceImpl implements ThemeModeLocalDatasource{

  Box<AppData> hiveBox;
  ShaxLogger logger;

  ThemeModeLocalDatasourceImpl({required this.hiveBox, required this.logger});

  @override
  Result<ThemeMode> getThemeMode() {
    try {
      CustomThemeMode themeMode = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!.themeMode;
      return Result.success(themeMode.customToSystem);
    }catch(error){
      String textError = "During getThemeMode localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

  @override
  Result<bool> putThemeMode(ThemeMode themeMode) {
    try{
      AppData appData = hiveBox.get(ApiConstants.appDataInstance, defaultValue: AppData.initial())!;
      AppData newAppData = appData.copyWith(themeMode: themeMode.systemToCustom);
      hiveBox.put(ApiConstants.appDataInstance, newAppData);
      return Result.success(true);
    }catch(error){
      String textError = "During putThemeMode localDatasource\nError ${error.toString()}";
      logger.logError(textError);
      return Result.error(textError);
    }
  }

}
