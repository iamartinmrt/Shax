import 'package:equatable/equatable.dart';
import 'package:shax/models/entities/product.dart';

class ProductState extends Equatable{

  final int homePageKey;
  final List<Product> itemList;
  final List<Product> newItemReceivedList;
  final bool isLoadingDataCompleted;
  final List<Product> savedList;

  const ProductState({
    required this.homePageKey,
    required this.newItemReceivedList,
    required this.itemList,
    required this.isLoadingDataCompleted,
    required this.savedList
  });

  factory ProductState.initial() =>
      const ProductState(itemList: <Product>[], savedList: <Product>[], newItemReceivedList: <Product>[], homePageKey: 0, isLoadingDataCompleted: false);

  ProductState copyWith({
    int? homePageKey,
    List<Product>? itemList,
    List<Product>? savedList,
    List<Product>? newItemReceivedList,
    bool? isLoadingDataCompleted,
  }) {
    return ProductState(
      homePageKey: homePageKey ?? this.homePageKey,
      itemList: itemList ?? this.itemList,
      newItemReceivedList: newItemReceivedList ?? this.newItemReceivedList,
      savedList: savedList ?? this.savedList,
      isLoadingDataCompleted: isLoadingDataCompleted ?? this.isLoadingDataCompleted,
    );
  }

  @override
  List<Object?> get props => [itemList, savedList, newItemReceivedList, homePageKey, isLoadingDataCompleted];
  
}