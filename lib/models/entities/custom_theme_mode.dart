import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'custom_theme_mode.g.dart';

/// An alternative for [ThemeMoe] because this class can cache by HiveBox.
@HiveType(typeId: 2)
enum CustomThemeMode{
  @HiveField(0)
  light,

  @HiveField(1)
  dark,
}

/// An extension to convert [ThemeMode] to [CustomThemeMode]
extension ThemeModeExtension on ThemeMode{
  CustomThemeMode get systemToCustom{
    switch(this){
      case ThemeMode.light:
        return CustomThemeMode.light;
      case ThemeMode.dark:
        return CustomThemeMode.dark;
      case ThemeMode.system:
        return CustomThemeMode.light;
    }
  }
}

/// An extension to convert [CustomThemeMode] to [ThemeMode]
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
