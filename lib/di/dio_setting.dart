import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:redux/redux.dart';
import 'package:shax/redux/actions/navigation_actions.dart';
import 'package:shax/redux/states/app_state.dart';


class DioCustomSetting {

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

  static void addInterceptor(Store<AppState> store){
    late Box<dynamic> hiveBox = DependencyProvider.get<Box<dynamic>>();
    ShaxLogger logger = DependencyProvider.get<ShaxLogger>();
    Dio dio = DependencyProvider.get<Dio>();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        RequestOptions newOptions = options;
        String userToken = hiveBox.get(ApiConstants.userToken, defaultValue: "");
        if(userToken != "") {
          newOptions.headers.putIfAbsent("Authorization", () => "Bearer $userToken");
        }
        logger.logInfo("Executing: ${options.method} - ${options.baseUrl}${options.path}");
        return handler.next(newOptions);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        Response newResponse = response;
        if(response.statusCode == 401){
          logger.logInfo("During call ${response.requestOptions.path} error ${response.statusCode}${response.statusMessage} occurred!");
          hiveBox.put(ApiConstants.userToken, "");
          store.dispatch(NavigateToLoginAction());
        }
        if (response.statusCode != 200 && response.statusCode != 201) {
          handler.reject(DioError(requestOptions: response.requestOptions, response: response, type: DioErrorType.response, error: "Status code is ${response.statusCode}"));
        }
        return handler.next(newResponse);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        logger.logError("During call ${error.response!.requestOptions.path} error ${error.response!.statusCode}${error.response!.statusMessage} occurred!\nError text: ${error.response!.data["message"]}");
        if(error.response!.statusCode == 401){
          hiveBox.put(ApiConstants.userToken, "");
          store.dispatch(NavigateToLoginAction());
        }
        return handler.next(error);
      },
    ));
  }

}