import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:redux/redux.dart';
import 'package:shax/models/entities/product.dart';
import 'package:shax/redux/actions/product_actions.dart';
import 'package:shax/redux/states/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageSize = 20;
  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _setNewItemsToController(_ViewModel vm) {
    try {
      final isLastPage = vm.newItemProducts.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(vm.newItemProducts);
        vm.changeLoadingCompleted(true);
      } else {
        final nextPageKey = vm.homePageKey + 1;
        _pagingController.appendPage(vm.newItemProducts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }

  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store){
        _pagingController.addPageRequestListener((pageKey) {
          if((store.state.productState.itemList.isNotEmpty) && (pageKey == 1)){
            _pagingController.appendPage(store.state.productState.itemList, store.state.productState.homePageKey+1);
          }else{
            store.dispatch(LoadProductListPageAction(
                listNewItems: <Product>[],
                listItems: store.state.productState.itemList,
                pageNumber: pageKey
            ));
          }
        });

      },
      onWillChange: (previousVm, newVm){
        if((previousVm != null) && (newVm.newItemProducts != previousVm.newItemProducts)){
          _setNewItemsToController(newVm);
        }
      },
      distinct: true,
      converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildBody(context, vm),
    );
  }

  Widget _buildBody(BuildContext context, _ViewModel vm){
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PagedListView<int, Product>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) =>
            SizedBox(
              width: _width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Colors.white,
                  elevation: 15.0,
                  child: Row(
                    children: [
                      Padding(padding: const EdgeInsets.all(5), child: Image.asset(GeneralConstants.homeSampleItemImage, width: (_width*0.2), height: (_width*0.2),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(vm.products[index].name, maxLines: 1,overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(vm.products[index].description, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

}

class _ViewModel {

  List<Product> products;
  List<Product> newItemProducts;
  Function(bool) changeLoadingCompleted;
  bool isLoadingCompleted;
  int homePageKey;

  _ViewModel({
    required this.products,
    required this.newItemProducts,
    required this.changeLoadingCompleted,
    required this.isLoadingCompleted,
    required this.homePageKey,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      products: store.state.productState.itemList,
      isLoadingCompleted: store.state.productState.isLoadingDataCompleted,
      changeLoadingCompleted: (bool isCompleted) =>
          store.dispatch(LoadingDataProcessCompleteChangeAction(isLoadingComplete: isCompleted)),
      newItemProducts: store.state.productState.newItemReceivedList,
      homePageKey: store.state.productState.homePageKey,
    );
  }
}
