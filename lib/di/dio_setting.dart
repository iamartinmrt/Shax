import 'dart:async';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';
import 'package:shax/common/event/navigation.dart';
import 'package:shax/redux/actions/navigation_actions.dart';
import 'package:shax/redux/states/app_state.dart';
import '../domain/usecase/local/put_user_local.dart';
import '../models/entities/app_data.dart';
import '../models/entities/user.dart';
import '../redux/actions/app_state_actions.dart';
import '../redux/actions/user_actions.dart';


class DioCustomSetting {

  /// Create instance of dio with initial information for DI
  static Dio createDio() {
    return Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeoutDuration,
      receiveTimeout: ApiConstants.receiveTimeoutDuration,
      headers: <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ));
  }


  /// Adding Interceptor to [Dio] to manage :
  /// - Adding UserToken to header every time we call an API
  /// - Checking on responses, if 401? send event [NavigationEvent] to [StreamController]
  static void addInterceptor(Store<AppState> store){
    ShaxLogger logger = DependencyProvider.get<ShaxLogger>();
    Dio dio = DependencyProvider.get<Dio>();
    StreamController streamController = DependencyProvider.get<StreamController>();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        RequestOptions newOptions = options;
        if(store.state.user.token != "") {
          newOptions.headers.putIfAbsent("Authorization", () => "Bearer ${store.state.user.token}");
        }
        logger.logInfo("Executing: ${options.method} - ${options.baseUrl}${options.path}");
        return handler.next(newOptions);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        Response newResponse = response;
        if (response.statusCode != 200 && response.statusCode != 201) {
          handler.reject(DioError(requestOptions: response.requestOptions, response: response, type: DioErrorType.response, error: "Status code is ${response.statusCode}"));
        }
        return handler.next(newResponse);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        if(error.response!.statusCode == 401){
          streamController.add(UnauthenticatedEvent.dioError(dioError: error));
          return handler.next(error);
        }
        logger.logError("During call ${error.response!.requestOptions.path} error ${error.response!.statusCode}${error.response!.statusMessage} occurred!\nError text: ${error.response!.data["message"]}");
        return handler.next(error);
      },
    ));
  }

}