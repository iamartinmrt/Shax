import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class User extends Equatable{

  @HiveField(0)
  final String token;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String email;

  const User({
    required this.token,
    required this.id,
    required this.email,
  });

  factory User.initial(){
    return const User(token: "", id: "", email: "");
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? token,
    String? id,
    String? email,
  }) {
    return User(
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, email, token];

}