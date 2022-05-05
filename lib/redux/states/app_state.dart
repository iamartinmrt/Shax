import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shax/models/entities/user.dart';
import 'package:shax/redux/states/product_state.dart';

class AppState{

  final User user;
  final ProductState productState;
  final ThemeMode themeMode;

  AppState({
    required this.productState,
    required this.user,
    required this.themeMode
  });

  factory AppState.initial() {
    return AppState(
      themeMode: ThemeMode.dark,
      user: User.initial(),
      productState: ProductState.initial(),
    );
  }

}