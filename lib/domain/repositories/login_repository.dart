import 'package:core/core.dart';
import '../../models/entities/user.dart';

abstract class LoginRepository{
  Future<Result<User>> callLoginAuth(Map<String, dynamic> body);
  Future<Result<bool>> callUpdateUser(Map<String, String> body);
}