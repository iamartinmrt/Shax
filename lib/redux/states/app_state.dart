import 'package:flutter/material.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/models/entities/user.dart';
import 'package:shax/redux/states/product_state.dart';

class AppState{

  final User user;
  final ProductState productState;

  AppState({
    required this.productState,
    required this.user,
  });

  factory AppState.initial() {
    return AppState(
      user: User.initial(),
      productState: ProductState.initial(),
    );
  }

}