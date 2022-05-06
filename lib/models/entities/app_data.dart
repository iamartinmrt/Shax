import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shax/models/entities/user.dart';

import 'custom_theme_mode.dart';
part 'app_data.g.dart';

@HiveType(typeId: 0)
class AppData extends Equatable{

  @HiveField(0)
  final User user;

  @HiveField(1)
  final CustomThemeMode themeMode;

  const AppData({
    required this.themeMode,
    required this.user
  });

  factory AppData.initial(){
    return AppData(themeMode: CustomThemeMode.light, user: User.initial());
  }

  AppData copyWith({
    User? user,
    CustomThemeMode? themeMode
  }) {
    return AppData(
      user: user ?? this.user,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [user, themeMode];

}