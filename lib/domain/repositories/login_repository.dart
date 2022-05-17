import 'package:core/core.dart';
import '../../models/entities/user.dart';

/// An interface to represent a repository that handle login APIs
abstract class LoginRepository{

  /// call api to authenticate by username and password
  /// if successful return User that tried to login
  Future<Result<User>> callLoginAuth(Map<String, dynamic> body);

  /// Call api to update user firebase token.
  Future<Result<bool>> callUpdateUser(Map<String, String> body);
}