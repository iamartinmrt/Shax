import 'package:equatable/equatable.dart';
import 'package:shax/models/entities/product.dart';

class ProductState extends Equatable{
  
  final List<Product>? itemList;
  final List<Product>? savedList;

  const ProductState({
    this.itemList,
    this.savedList
  });

  factory ProductState.initial() =>
      const ProductState(itemList: <Product>[], savedList: <Product>[]);

  ProductState copyWith({
    List<Product>? itemList,
    List<Product>? savedList,
  }) {
    return ProductState(
      itemList: itemList ?? this.itemList,
      savedList: savedList ?? this.savedList
    );
  }

  @override
  List<Object?> get props => [itemList, savedList];
  
}