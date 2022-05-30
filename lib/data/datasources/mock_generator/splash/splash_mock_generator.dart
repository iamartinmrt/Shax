import 'dart:async';
import 'dart:convert';
import 'package:core/core.dart';
import 'package:shax/common/event/navigation.dart';
import '../../../../models/entities/init_call.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Different situations that can happen on response Splash
enum SplashTestCase{
  unauthorized,
  authorized
}

class MockDataGenerator{

  StreamController streamController;

  MockDataGenerator({required this.streamController});

  Future<Result<InitCall>> fetchInitialCall(SplashTestCase testCase)async{
    await Future.delayed(const Duration(seconds: 2));

    switch(testCase){
      case SplashTestCase.authorized:
        try {
          return Result.success(InitCall.fromJson(jsonDecode(await loadAsset())["data"]));
        }catch(error){
          return Result.error(error);
        }
      case SplashTestCase.unauthorized:
        streamController.add(UnauthenticatedEvent.customError(
            customError: "During call fetchInitialCall in MockDataGenerator unauthenticated error occurred!"));
        throw Exception("401 unauthenticated");
    }
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString(GeneralConstants.dataSampleSplashInitCall);
  }

}
