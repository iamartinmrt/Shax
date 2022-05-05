import 'package:redux/redux.dart';

import '../../models/entities/user.dart';
import '../actions/user_actions.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserInfoAction>(_updateUserInfo),
  // TypedReducer<User, LogoutUserAction>(_logoutUser),
]);

User _updateUserInfo(User state, UpdateUserInfoAction action) =>
    state.copyWith(
        token: action.userToken ?? state.token,
        id: action.id ?? state.id,
        email: action.email ?? state.email,
    );

// User _logoutUser(User state, LogoutUserAction action) =>
//     state.copyWith(token: "", id: "", email: "");
