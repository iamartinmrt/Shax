import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'init_call.g.dart';

@JsonSerializable(explicitToJson: true)
class InitCall extends Equatable{

  @JsonKey(name: "current_version")
  final double currentVersion;

  const InitCall({
    required this.currentVersion,
  });

  factory InitCall.fromJson(Map<String, dynamic> json) => _$InitCallFromJson(json);

  Map<String, dynamic> toJson() => _$InitCallToJson(this);

  @override
  List<Object?> get props => [currentVersion];
}
