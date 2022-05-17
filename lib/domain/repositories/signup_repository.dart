import 'package:core/core.dart';
import 'package:shax/models/request/auth_request.dart';

/// An interface to represent a repository that handle signup APIs
abstract class SignupRepository{

  /// call signup
  Future<Result<bool>> callSignupAuth(Map<String, dynamic> body);
}