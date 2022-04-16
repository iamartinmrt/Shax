import 'package:shax/models/entities/product.dart';

class LoadProductListPageAction{
  List<Product>? listItems;
  List<Product>? listNewItems;
  int pageNumber;
  bool isRefresh;
  LoadProductListPageAction({this.listItems, required this.pageNumber, this.listNewItems, required this.isRefresh});
  LoadProductListPageAction copyWith({
    List<Product>? listItems,
    List<Product>? listNewItems,
    int? pageNumber,
    bool? isRefresh,
  }){
    return LoadProductListPageAction(
      listItems: listItems ?? this.listItems,
      listNewItems: listNewItems ?? this.listNewItems,
      pageNumber: pageNumber ?? this.pageNumber,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }
}

class LoadingDataProcessCompleteChangeAction{
  final bool isLoadingComplete;
  LoadingDataProcessCompleteChangeAction({required this.isLoadingComplete});
}

class RefreshListProductsAction{}
