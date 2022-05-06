import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redux/redux.dart';
import 'package:shax/domain/usecase/local/put_theme_mode_local.dart';
import 'package:shax/domain/usecase/local/put_user_local.dart';
import 'package:shax/models/entities/app_data.dart';

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

  late Box<AppData> hiveBox;
  late PutUserLocal putUserLocal;
  late PutThemeModeLocal putThemeModeLocal;

  @override
  void initState() {
    hiveBox = DependencyProvider.get<Box<AppData>>();
    putUserLocal = DependencyProvider.get<PutUserLocal>();
    putThemeModeLocal = DependencyProvider.get<PutThemeModeLocal>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm){
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoSwitch(
                value: vm.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if(value){
                    putThemeModeLocal(ThemeMode.dark);
                    vm.changeAppTheme(ThemeMode.dark);
                  }else{
                    putThemeModeLocal(ThemeMode.light);
                    vm.changeAppTheme(ThemeMode.light);
                  }
                },
              ),
              ElevatedButton(
                  onPressed: (){
                    putUserLocal(User.initial());
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
