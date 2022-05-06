import 'package:core/src/utils/result.dart';
import 'package:flutter/src/material/app.dart';
import 'package:shax/data/datasources/local/theme/theme_mode_local_datasource.dart';
import 'package:shax/domain/repositories/local/theme_mode_repository.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository{

  ThemeModeLocalDatasource datasource;

  ThemeModeRepositoryImpl({required this.datasource});

  @override
  Result<ThemeMode> getThemeMode() {
    return datasource.getThemeMode();
  }

  @override
  Result<bool> putThemeMode(ThemeMode themeMode) {
    return datasource.putThemeMode(themeMode);
  }

}