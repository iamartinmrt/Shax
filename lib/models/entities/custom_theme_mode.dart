import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
enum CustomThemeMode{
  @HiveField(0)
  light,

  @HiveField(1)
  dark,
}

extension ThemeModeExtension on ThemeMode{
  CustomThemeMode get systemToCustom{
    switch(this){
      case ThemeMode.light:
        return CustomThemeMode.light;
      case ThemeMode.dark:
        return CustomThemeMode.dark;
      default:
        return CustomThemeMode.light;
    }
  }
}

extension CustomThemeModeExtension on CustomThemeMode{
  ThemeMode get customToSystem{
    switch(this){
      case CustomThemeMode.light:
        return ThemeMode.light;
      case CustomThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}
