import 'package:core/core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shax/common/keys.dart';
import 'package:shax/navigation/route/app_route.dart';
import '../states/app_state.dart';
import 'package:shax/redux/actions/navigation_actions.dart';

List<Middleware<AppState>> navigationMiddleware(ShaxLogger logger) {
  final loginNavigationMiddleware = _navigateToLoginAction(logger);
  final dashboardScreenNavigationMiddleware = _navigateToDashboardScreenAction(logger);
  final signUpNavigationMiddleware = _navigateToSignUpAction(logger);
  final onShowSelectedProductPageAction = _onShowSelectedProductPageAction(logger);

  return [
    TypedMiddleware<AppState, NavigateToSignUpAction>(signUpNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToDashboardScreenAction>(dashboardScreenNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToLoginAction>(loginNavigationMiddleware),
    TypedMiddleware<AppState, NavigateToProductDetail>(onShowSelectedProductPageAction),
  ];
}

Middleware<AppState> _onShowSelectedProductPageAction(ShaxLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState!.pushNamed(
        AppRoute.productDetail);
  };
}

Middleware<AppState> _navigateToLoginAction(ShaxLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoute.login, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToDashboardScreenAction(ShaxLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo(action.toString());
    // next(action);
    Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoute.dashboard, (Route<dynamic> route) => false);
  };
}

Middleware<AppState> _navigateToSignUpAction(ShaxLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    logger.logInfo(action.toString());
    Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoute.signup, (Route<dynamic> route) => false);
  };
}
