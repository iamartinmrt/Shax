import 'package:redux/redux.dart';

import '../../models/entities/user.dart';
import '../actions/app_state_actions.dart';
import '../actions/user_actions.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserInfoAction>(_updateUserInfo),
  TypedReducer<User, OnAppDataChanged>(_updateUserAppDataInfo),
]);

User _updateUserInfo(User state, UpdateUserInfoAction action) =>
    state.copyWith(
        token: action.userToken ?? state.token,
        id: action.id ?? state.id,
        email: action.email ?? state.email,
    );

User _updateUserAppDataInfo(User state, OnAppDataChanged action) =>
    state.copyWith(
      token: action.appData.user.token,
      id: action.appData.user.id,
      email: action.appData.user.email,
    );

