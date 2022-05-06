import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shax/domain/repositories/local/theme_mode_repository.dart';
import '../../../models/request/no_param_request.dart';

class GetThemeModeLocal extends UseCaseSync<ThemeMode, NoParamRequest>{

  ThemeModeRepository repository;

  GetThemeModeLocal({required this.repository});

  @override
  Result<ThemeMode> call(NoParamRequest params){
    return repository.getThemeMode();
  }

}