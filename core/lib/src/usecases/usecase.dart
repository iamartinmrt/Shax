import 'package:core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}
