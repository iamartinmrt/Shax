import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class ThemeModeRepository{
  Result<ThemeMode> getThemeMode();
  Result<bool> putThemeMode(ThemeMode themeMode);
}