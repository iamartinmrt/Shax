import 'package:core/core.dart';

abstract class LoginRepository{
  Future<Result<String>> callLoginAuth(Map<String, dynamic> body);
  Future<Result<bool>> callUpdateUser(Map<String, String> body);
}