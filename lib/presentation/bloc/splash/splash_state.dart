import 'package:core/core.dart';
import 'package:shax/models/entities/init_call.dart';

class SplashState {
  final bool isInitial;
  final bool isFailed;
  final FormSubmissionStatus formStatus;
  final InitCall initCall;

  SplashState({
    this.isInitial = true,
    this.isFailed = false,
    this.formStatus = const InitialFormStatus(),
    this.initCall = const InitCall(currentVersion: 0),
  });

  SplashState copyWith({
    bool? isInitial,
    bool? isFailed,
    FormSubmissionStatus? formStatus,
    InitCall? initCall,
  }){
    return SplashState(
      isFailed: isFailed ?? this.isFailed,
      isInitial: isInitial ?? this.isInitial,
      formStatus: formStatus ?? this.formStatus,
      initCall:  initCall ?? this.initCall,
    );
  }
}