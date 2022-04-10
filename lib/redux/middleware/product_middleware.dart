import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:shax/domain/usecase/product_fetch_list_products.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/models/request/list_products_request.dart';
import 'package:shax/redux/actions/product_actions.dart';
import 'package:shax/redux/states/app_state.dart';


List<Middleware<AppState>> productMiddleware(ShaxLogger logger, ProductFetchListProducts fetchListProducts) {

  final onLoadProductListPageAction = _onLoadProductListPageAction(logger, fetchListProducts);

  return [
    TypedMiddleware<AppState, LoadProductListPageAction>(onLoadProductListPageAction),
  ];
}

Middleware<AppState> _onLoadProductListPageAction(ShaxLogger logger, ProductFetchListProducts fetchListProducts){
  return (Store<AppState> store, action, NextDispatcher next)async{
    logger.logInfo(action.toString());
    var data = action as LoadProductListPageAction;

    try {
      final _result = await fetchListProducts(ListProductsRequest(page: data.pageNumber));
      logger.logInfo("$action _onLoadCompletedWorkoutsHistoryAction ${_result.toString()}");
      if(_result.isSuccess()){
        action.listItems.addAll(_result.content!);
      }
    }catch(error){
      if(error is! DioError) {
        logger.logError("During _onLoadProductListPageAction productMiddleware\nError: ${error.toString()}");
      }
    }

    next(action);
  };
}
