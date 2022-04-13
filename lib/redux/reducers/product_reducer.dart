import 'package:redux/redux.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/redux/actions/product_actions.dart';
import 'package:shax/redux/states/product_state.dart';

final productReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, LoadProductListPageAction>(_showLoadingAction),
  TypedReducer<ProductState, LoadingDataProcessCompleteChangeAction>(_changeIsLoadingCompletedAction),
]);

ProductState _showLoadingAction(ProductState state, LoadProductListPageAction action) =>
    state.copyWith(itemList: action.listItems, newItemReceivedList: action.listNewItems, homePageKey: action.pageNumber);

ProductState _changeIsLoadingCompletedAction(ProductState state, LoadingDataProcessCompleteChangeAction action) =>
    state.copyWith(isLoadingDataCompleted: action.isLoadingComplete);
