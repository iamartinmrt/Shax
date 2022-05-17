import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// An interface to represent a repository that get and put ThemeMode to local cache
abstract class ThemeModeRepository{

  /// Get ThemeMode from local cache
  Result<ThemeMode> getThemeMode();

  /// Put ThemeMode to local cache
  Result<bool> putThemeMode(ThemeMode themeMode);
}
