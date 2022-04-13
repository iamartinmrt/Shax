import 'package:shax/models/entities/product.dart';

class LoadProductListPageAction{
  List<Product>? listItems;
  List<Product>? listNewItems;
  int pageNumber;
  LoadProductListPageAction({this.listItems, required this.pageNumber, this.listNewItems});
  LoadProductListPageAction copyWith({
    List<Product>? listItems,
    List<Product>? listNewItems,
    int? pageNumber,
  }){
    return LoadProductListPageAction(
      listItems: listItems ?? this.listItems,
      listNewItems: listNewItems ?? this.listNewItems,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}

class LoadingDataProcessCompleteChangeAction{
  final bool isLoadingComplete;
  LoadingDataProcessCompleteChangeAction({required this.isLoadingComplete});
}

