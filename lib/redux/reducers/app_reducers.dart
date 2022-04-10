import 'package:flutter/material.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/models/entities/user.dart';
import 'package:shax/redux/actions/app_state_actions.dart';
import 'package:shax/redux/reducers/product_reducer.dart';
import 'package:shax/redux/states/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    productState: productReducer(state.productState, action),
    user: null,
    appLifecycleState: appLifecycleStateReducer(state.appLifecycleState!, action),
  );
}

AppLifecycleState appLifecycleStateReducer(AppLifecycleState state, dynamic action) {
  if (action is OnAppStateChangedAction) {
    return action.state;
  }
  return state;
}