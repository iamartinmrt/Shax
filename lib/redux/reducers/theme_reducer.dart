
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../actions/app_state_actions.dart';

final appThemeReducer = combineReducers<ThemeMode>([
  TypedReducer<ThemeMode, OnThemeDataChanged>(_changeAppTheme),
]);

ThemeMode _changeAppTheme(ThemeMode state, OnThemeDataChanged action) {
  return action.themeMode;
}
