import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../actions/app_state_actions.dart';
import '../../../../models/entities/custom_theme_mode.dart';

final appThemeReducer = combineReducers<ThemeMode>([
  TypedReducer<ThemeMode, OnThemeDataChanged>(_changeAppTheme),
  TypedReducer<ThemeMode, OnAppDataChanged>(_changeThemeAppData),
]);

ThemeMode _changeAppTheme(ThemeMode state, OnThemeDataChanged action) {
  return action.themeMode;
}

ThemeMode _changeThemeAppData(ThemeMode state, OnAppDataChanged action) {
  return action.appData.themeMode.customToSystem;
}
