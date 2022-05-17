import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shax/models/entities/user.dart';

import 'custom_theme_mode.dart';
part 'app_data.g.dart';

/// A data class that holds Application states
/// [AppData.user] : Contains information of the logged in user
/// [AppData.themeMode] : Customize the application theme mode. This is a custom version of [ThemeMode]. Because we can't cache the [ThemeMode] as a member of [AppData] in HiveBox. We user [CustomThemeMode] for caching but in case of usage we convert it to [ThemeMode] by [ThemeModeExtension] or [CustomThemeModeExtension]
/// [AppData.fcmToken] : Firebase token.

@HiveType(typeId: 0)
class AppData extends Equatable{

  @HiveField(0)
  final User user;

  @HiveField(1)
  final CustomThemeMode themeMode;

  @HiveField(2)
  final String fcmToken;

  const AppData({
    required this.themeMode,
    required this.user,
    required this.fcmToken
  });

  factory AppData.initial(){
    return AppData(themeMode: CustomThemeMode.light, user: User.initial(), fcmToken: "");
  }

  AppData copyWith({
    User? user,
    CustomThemeMode? themeMode,
    String? fcmToken
  }) {
    return AppData(
      user: user ?? this.user,
      themeMode: themeMode ?? this.themeMode,
      fcmToken: fcmToken ?? this.fcmToken
    );
  }

  @override
  List<Object?> get props => [user, themeMode, fcmToken];

}