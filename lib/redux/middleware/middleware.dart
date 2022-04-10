import 'dart:core';
import 'package:core/core.dart';
import 'package:shax/domain/usecase/product_fetch_list_products.dart';
import 'package:shax/redux/middleware/product_middleware.dart';
import 'package:shax/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'navigation_middleware.dart';


List<Middleware<AppState>> createAppMiddleware(
    ShaxLogger logger,
    ProductFetchListProducts fetchListProducts,
    ){
  final List<Middleware<AppState>> appMiddleware = [];
  appMiddleware.addAll(navigationMiddleware(logger));
  appMiddleware.addAll(productMiddleware(logger, fetchListProducts));

  return appMiddleware;
}
