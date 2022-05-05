import 'package:core/core.dart';
import '../../../models/entities/user.dart';

abstract class UserRepository{
  Result<User> getUser();
  Result<bool> putUser(User user);
}