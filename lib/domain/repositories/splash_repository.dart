import 'package:core/core.dart';
import 'package:shax/models/entities/init_call.dart';

abstract class SplashRepository{
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams);
}