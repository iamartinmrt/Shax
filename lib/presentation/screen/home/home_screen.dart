import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:redux/redux.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/redux/states/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const _pageSize = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
      converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildBody(context, vm),
    );
  }

  Widget _buildBody(BuildContext context, _ViewModel vm){
    return Container();
  }

}

class _ViewModel {

  List<Product> products;

  _ViewModel({
    required this.products,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        products: store.state.productState.itemList ?? <Product>[],
    );
  }
}
