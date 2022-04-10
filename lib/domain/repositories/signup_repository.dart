import 'package:core/core.dart';

abstract class SignupRepository{
  Future<Result<bool>> callSignupAuth(Map<String, dynamic> body);
}