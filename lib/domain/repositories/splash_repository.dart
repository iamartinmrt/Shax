import 'package:core/core.dart';
import 'package:shax/models/entities/init_call.dart';

/// An interface to represent a repository that handle splash APIs
abstract class SplashRepository{

  /// Fetch initial call to receive latest version
  Future<Result<InitCall>> fetchInitCall(Map<String, dynamic> queryParams);
}