import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shax/models/entities/init_call.dart';
import 'base_model.dart';

// import 'package:shax/models/base_model.dart';
// part 'response_content.g.dart';

class ResponseContent<T extends BaseModel> extends Equatable {
// class ResponseContent<T> extends Equatable{

  // final Map<String, dynamic>? data;
  // final T data;
  final String? message;
  final int? currentTime;
  final bool success;
  final int? index;
  final int? total;
  final String? devError;
  final String? errors;

  const ResponseContent(
      {
        // required this.data,
      this.message,
      this.currentTime,
      required this.success,
      this.index,
      this.total,
      this.devError,
      this.errors});

  factory ResponseContent.fromJson(Map<String, dynamic> json) =>
      ResponseContent(
        // data: (T as BaseModel).fromJson(json['data']),
        message: json['message'] as String?,
        currentTime: json['currentTime'] as int?,
        success: json['success'] as bool,
        index: json['index'] as int?,
        total: json['total'] as int?,
        devError: json['devError'] as String?,
        errors: json['errors'] as String?,
      );

  @override
  List<Object?> get props =>
      [message, currentTime, success, index, total, devError, errors];

// @override
// List<Object?> get props => [data, message, currentTime, success, index, total, devError, errors];

}
