import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _refreshController.dispose();
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
      onInit: (store) {
        _pagingController.addPageRequestListener((pageKey) {
          if ((store.state.productState.itemList.isNotEmpty) && (pageKey == 1)) {
            _pagingController.appendPage(store.state.productState.itemList, store.state.productState.homePageKey + 1);
          } else {
            store.dispatch(LoadProductListPageAction(
              listNewItems: <Product>[],
              listItems: store.state.productState.itemList,
              pageNumber: pageKey,
              isRefresh: false,
            ));
          }
        });
      },
      onWillChange: (previousVm, newVm) {
        if (previousVm != null) {
          if(previousVm.isRefresh != newVm.isRefresh){
            if(newVm.isRefresh){
              _pagingController.refresh();
              return;
            }else{
              _refreshController.refreshCompleted();
            }
          }
          if (newVm.newItemProducts != previousVm.newItemProducts){
            print("old page number : ${previousVm.homePageKey}, new Page number : ${newVm.homePageKey}");
            _setNewItemsToController(newVm);
          }
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: ()=> vm.onRefresh(),
        child: PagedListView<int, Product>(
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
                            Text(item.name, maxLines: 1,overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text(item.description, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }

}

class _ViewModel {

  List<Product> products;
  List<Product> newItemProducts;
  Function(bool) changeLoadingCompleted;
  Function() onRefresh;
  bool isRefresh;
  int homePageKey;

  _ViewModel({
    required this.products,
    required this.newItemProducts,
    required this.onRefresh,
    required this.changeLoadingCompleted,
    required this.homePageKey,
    required this.isRefresh,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      products: store.state.productState.itemList,
      isRefresh: store.state.productState.isRefresh,
      changeLoadingCompleted: (bool isCompleted) => store.dispatch(LoadingDataProcessCompleteChangeAction(isLoadingComplete: isCompleted)),
      onRefresh: () => store.dispatch(RefreshListProductsAction()),
      newItemProducts: store.state.productState.newItemReceivedList,
      homePageKey: store.state.productState.homePageKey,
    );
  }
}
