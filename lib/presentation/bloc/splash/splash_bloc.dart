import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shax/domain/usecase/splash_fetch_init_call.dart';
import 'package:shax/models/entities/init_call.dart';
import 'bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{

  final SplashFetchInitCall fetchInitCall;

  SplashBloc({required this.fetchInitCall}) : super(SplashState()){
    on<SplashFetchData>(_onFetchData);
    on<SplashIsFailedChanged>(_onIsFailedChanged);
    on<SplashFormStatusChanged>(_onFormStatusChanged);
  }

  void _onFormStatusChanged(SplashFormStatusChanged statusChanged, Emitter<SplashState> emit){
    emit(state.copyWith(
        formStatus: statusChanged.formStatus
    ));
  }

  Future<void> _onFetchData(SplashFetchData fetchData, Emitter<SplashState> emit) async{
    // start Loading...
    emit(state.copyWith(
        formStatus: FormSubmitting(),
        isFailed: false,
        isInitial: false
    ));
    // start fetching...
    var appVersion = await PackageInfo.fromPlatform();

    await Future.delayed(const Duration(seconds: 2)).then((value) async{
      final Result<InitCall> result = await fetchInitCall(appVersion.version);

      if(result.isSuccess()){
        emit(state.copyWith(
          initCall: result.content,
          formStatus: SubmissionSuccess(),
          isInitial: false,
          isFailed: false,
        ));
      }else{
        emit(state.copyWith(
          formStatus: SubmissionFailed(result.error!),
          isInitial: false,
          isFailed: true,
        ));
      }
    });

  }

  void _onIsFailedChanged(SplashIsFailedChanged isFailedChanged, Emitter<SplashState> emit){
    emit(state.copyWith(
        isFailed: isFailedChanged.isFailed
    ));
  }

}