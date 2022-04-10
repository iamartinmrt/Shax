import 'package:flutter/material.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/models/entities/user.dart';
import 'package:shax/redux/states/product_state.dart';

class AppState{

  final AppLifecycleState? appLifecycleState;
  // final LoginAuthState loginAuthState;
  final User? user;
  final ProductState productState;

  AppState({
    required this.productState,
    this.appLifecycleState,
    this.user,
    // this.loginAuthState,
  });

  factory AppState.initial() {
    return AppState(
      // loginAuthState: null,
      appLifecycleState: null,
      user: null,
      productState: ProductState.initial(),
    );
  }

}