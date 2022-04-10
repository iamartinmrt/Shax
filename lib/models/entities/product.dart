import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable{

  String id;
  User user;
  String name;
  String description;

  Product({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, user, name, description];

}