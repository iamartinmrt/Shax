import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';

import '../../../models/entities/user.dart';
import '../../../redux/actions/app_state_actions.dart';
import '../../../redux/actions/navigation_actions.dart';
import '../../../redux/actions/user_actions.dart';
import '../../../redux/states/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late Box<User> hiveBox;

  @override
  void initState() {
    hiveBox = DependencyProvider.get<Box<User>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm){
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoSwitch(
                value: vm.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  // TODO : cache the value
                  if(value){
                    vm.changeAppTheme(ThemeMode.dark);
                  }else{
                    vm.changeAppTheme(ThemeMode.light);
                  }
                },
              ),
              ElevatedButton(
                  onPressed: (){
                    hiveBox.put(ApiConstants.userInstance, const User(token: "", id: "", email: ""));
                    StoreProvider.of<AppState>(context).dispatch(NavigateToLoginAction());
                  },
                  child: const Text("Logout")
              )
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {

  final String userEmail;
  final String userToken;
  final String userId;
  final Function(ThemeMode) changeAppTheme;
  final ThemeMode themeMode;

  _ViewModel({
    required this.themeMode,
    required this.userToken,
    required this.userEmail,
    required this.userId,
    required this.changeAppTheme,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      themeMode: store.state.themeMode,
      changeAppTheme: (themeMode) => store.dispatch(OnThemeDataChanged(themeMode: themeMode)),
      userEmail: store.state.user.email,
      userToken: store.state.user.token,
      userId: store.state.user.id,
    );
  }
}
