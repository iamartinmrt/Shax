import 'package:core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

abstract class UseCaseSync<Type, Params> {
  Result<Type> call(Params params);
}
