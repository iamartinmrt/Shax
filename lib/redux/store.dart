import 'package:core/core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';
import 'package:shax/common/flavor/flavor_config.dart';
import 'package:shax/domain/usecase/product_fetch_list_products.dart';
import 'package:shax/redux/reducers/app_reducers.dart';
import 'package:shax/redux/states/app_state.dart';

import 'middleware/middleware.dart';

Future<Store<AppState>> createStore(FlavorConfig flavorConfig)async{

  DependencyProvider.registerSingleton<Box<dynamic>>(await Hive.openBox<dynamic>(GeneralConstants.hiveBoxName)); // TODO : encrypt hive data

  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createAppMiddleware(
      DependencyProvider.get<ShaxLogger>(),
      DependencyProvider.get<ProductFetchListProducts>()
    ),
  );
}
