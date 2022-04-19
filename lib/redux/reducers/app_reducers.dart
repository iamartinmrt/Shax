import 'package:shax/redux/reducers/product_reducer.dart';
import 'package:shax/redux/reducers/user_reducer.dart';
import 'package:shax/redux/states/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    productState: productReducer(state.productState, action),
    user: userReducer(state.user, action),
  );
}
