import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

/// A data class that holds details of a product
/// [Product.id] : Unique product id.
/// [Product.name] : Name of the product
/// [Product.description] : description of the product

@JsonSerializable(explicitToJson: true)
class Product extends Equatable{

  final String id;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, name, description];

}