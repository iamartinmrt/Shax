import 'package:core/core.dart';

abstract class SplashEvent{}

class SplashIsInitialChange extends SplashEvent{
  final bool isInitial;
  SplashIsInitialChange(this.isInitial);
}

class SplashFetchData extends SplashEvent{}

class SplashIsFailedChanged extends SplashEvent{
  final bool isFailed;
  SplashIsFailedChanged(this.isFailed);
}

class SplashFormStatusChanged extends SplashEvent{
  final FormSubmissionStatus formStatus;
  SplashFormStatusChanged(this.formStatus);
}
