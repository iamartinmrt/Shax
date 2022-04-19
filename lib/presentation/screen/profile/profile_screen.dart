import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../redux/states/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm){
        return Center(
          child: Text("${vm.userEmail} - ${vm.userId}\n${vm.userToken}"),
        );
      },
    );
  }
}

class _ViewModel {

  final String userEmail;
  final String userToken;
  final String userId;

  _ViewModel({
    required this.userToken,
    required this.userEmail,
    required this.userId,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      userEmail: store.state.user.email,
      userToken: store.state.user.token,
      userId: store.state.user.id,
    );
  }
}
