import 'package:redux/redux.dart';
import 'package:shax/redux/actions/product_actions.dart';
import 'package:shax/redux/states/product_state.dart';

final productReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, LoadProductListPageAction>(_showLoadingAction),
]);

ProductState _showLoadingAction(ProductState state, LoadProductListPageAction action) =>
    state.copyWith(itemList: action.listItems);
