import 'package:equatable/equatable.dart';
import 'package:shax/models/entities/product.dart';

class ProductState extends Equatable{

  final int homePageKey;
  final List<Product> itemList;
  final List<Product> newItemReceivedList;
  final bool isRefresh;

  const ProductState({
    required this.homePageKey,
    required this.newItemReceivedList,
    required this.itemList,
    required this.isRefresh,
  });

  factory ProductState.initial() =>
      const ProductState(itemList: <Product>[], newItemReceivedList: <Product>[], homePageKey: 0, isRefresh: false);

  ProductState copyWith({
    int? homePageKey,
    List<Product>? itemList,
    List<Product>? newItemReceivedList,
    bool? isRefresh,
  }) {
    return ProductState(
      homePageKey: homePageKey ?? this.homePageKey,
      itemList: itemList ?? this.itemList,
      newItemReceivedList: newItemReceivedList ?? this.newItemReceivedList,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }

  @override
  List<Object?> get props => [itemList, newItemReceivedList, homePageKey, isRefresh];
  
}