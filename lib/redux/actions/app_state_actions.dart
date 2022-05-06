import 'package:flutter/material.dart';

import '../../models/entities/app_data.dart';

class OnAppStateChangedAction {
  final AppLifecycleState state;

  OnAppStateChangedAction({required this.state});
}

class OnThemeDataChanged{
  final ThemeMode themeMode;
  OnThemeDataChanged({required this.themeMode});
}

class OnAppDataChanged{
  final AppData appData;
  OnAppDataChanged({required this.appData});
}
