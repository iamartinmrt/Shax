import 'package:flutter/material.dart';
import 'package:shax/presentation/screen/product_detail/product_detail.dart';
import 'package:shax/presentation/screen/screen.dart';

class AppRoute {

  /// For each screen create new route to use for routing
  static const splash = "/to_splash";
  static const login = "/to_login";
  static const signup = "/to_signup";
  static const dashboard = "/to_dashboard";
  static const productDetail = "/to_product_detail";

  /// In [routeMap] for each string route that you created you add [MaterialPageRoute]
  /// It creates a [Map] with ([String] key) and ([Route] value).
  static final routeMap = {
    splash: (setting) => MaterialPageRoute(
      builder: (BuildContext context) => const SplashScreen(),
      settings: setting,
    ),
    login: (settings) => MaterialPageRoute(
      builder: (BuildContext context) => const LoginScreen(),
      settings: settings,
    ),
    signup: (setting) => MaterialPageRoute(
      builder: (BuildContext context) => const SignupScreen(),
      settings: setting,
    ),
    dashboard: (settings) => MaterialPageRoute(
      builder: (BuildContext context) => const DashboardScreen(),
      settings: settings,
    ),
    productDetail: (settings) => MaterialPageRoute(
      builder: (BuildContext context) => const ProductDetail(),
      settings: settings,
    ),
  };
}
