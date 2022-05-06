import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shax/domain/repositories/local/theme_mode_repository.dart';

class PutThemeModeLocal extends UseCaseSync<bool, ThemeMode>{

  ThemeModeRepository repository;

  PutThemeModeLocal({required this.repository});

  @override
  Result<bool> call(ThemeMode params){
    return repository.putThemeMode(params);
  }

}