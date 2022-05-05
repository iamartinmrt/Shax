import 'package:flutter/material.dart';

class OnAppStateChangedAction {
  final AppLifecycleState state;

  OnAppStateChangedAction({required this.state});
}

class OnThemeDataChanged{
  final ThemeMode themeMode;
  OnThemeDataChanged({required this.themeMode});
}