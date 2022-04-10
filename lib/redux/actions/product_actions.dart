import 'package:shax/models/entities/product.dart';

class LoadProductListPageAction{
  List<Product> listItems;
  int pageNumber;
  LoadProductListPageAction({required this.listItems, required this.pageNumber});
  set age(List<Product> listItems){
    this.listItems = listItems;
  }
}
