import 'package:core/core.dart';
import '../../../models/entities/user.dart';

/// An interface to represent a repository that get and put User to local cache
abstract class UserRepository{

  /// Get User from local cache
  Result<User> getUser();

  /// Put User to local cache
  Result<bool> putUser(User user);
}