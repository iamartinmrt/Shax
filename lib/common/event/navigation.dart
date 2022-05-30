import 'package:dio/dio.dart';
import 'package:shax/data/datasources/mock_generator/splash/splash_mock_generator.dart';


/// This is an Event to send and receive across an stream in the application to
/// notice unauthenticated.
///
/// [UnauthenticatedEvent.dioError] : usage is when you receive [DioError] from
/// a response of calling an API with [Dio]
///
/// [UnauthenticatedEvent.customError] : usage is when you call it from classes
/// like [MockDataGenerator] and you want to create custom error
///
class UnauthenticatedEvent{

  factory UnauthenticatedEvent.customError({required String customError}) =>
      UnauthenticatedEvent._(customErrorMessage: customError);

  factory UnauthenticatedEvent.dioError({required DioError dioError}) =>
      UnauthenticatedEvent._(dioError: dioError);

  UnauthenticatedEvent._({this.dioError, this.customErrorMessage});

  DioError? dioError;
  String? customErrorMessage;
}