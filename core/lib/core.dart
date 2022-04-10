library core;

import 'package:core/src/di/dependency_provider.dart';
import 'package:core/src/secure/jwt_token_provider.dart';
export 'src/di/dependency_provider.dart';
export 'src/constants/constants.dart';
export 'src/form_status/form_submission_status.dart';
export 'src/utils/result.dart';
export 'src/constants/api_constants.dart';
export 'src/logger/shax_logger.dart';
export 'src/secure/jwt_token_provider.dart';
export 'src/usecases/usecase.dart';
export 'src/constants/text_constants.dart';

class CoreModuleInitializer {
  static void init() {
    // DependencyProvider.registerSingleton<JwtProvider>(JwtProvider());
  }
}