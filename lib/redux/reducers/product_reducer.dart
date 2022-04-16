import 'package:redux/redux.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/redux/actions/product_actions.dart';
import 'package:shax/redux/states/product_state.dart';

final productReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, LoadProductListPageAction>(_showLoadingAction),
  TypedReducer<ProductState, RefreshListProductsAction>(_onRefreshListProducts),
]);

ProductState _showLoadingAction(ProductState state, LoadProductListPageAction action) =>
    state.copyWith(itemList: action.listItems, newItemReceivedList: action.listNewItems, homePageKey: action.pageNumber, isRefresh: action.isRefresh);

ProductState _onRefreshListProducts(ProductState state, RefreshListProductsAction action) =>
    state.copyWith(homePageKey: 1, itemList: <Product>[], newItemReceivedList: <Product>[], isRefresh: true);

// ProductState _changeIsLoadingCompletedAction(ProductState state, LoadingDataProcessCompleteChangeAction action) =>
//     state.copyWith(isLoadingDataCompleted: action.isLoadingComplete);