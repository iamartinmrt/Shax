import 'package:flutter/material.dart';
import 'package:shax/presentation/screen/product_detail/product_detail.dart';
import 'package:shax/presentation/screen/screen.dart';
import 'no_transition_route.dart';

class AppRoute {
  static const splash = "/to_splash";
  static const login = "/to_login";
  static const signup = "/to_signup";
  static const dashboard = "/to_dashboard";
  static const productDetail = "/to_product_detail";

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
