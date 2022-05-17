import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shax/domain/usecase/local/put_user_local.dart';
import 'package:shax/domain/usecase/login_call_login_auth.dart';
import 'package:shax/domain/usecase/login_call_update_user.dart';
import 'package:shax/models/request/auth_request.dart';
import '../../../../models/entities/app_data.dart';
import '../../../../models/entities/user.dart';
import 'bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{

  LoginCallLoginAuth callLoginAuth;
  LoginCallUpdateUser callUpdateUser;
  PutUserLocal putUserLocal;
  ShaxLogger logger;

  LoginBloc({
    required this.logger,
    required this.putUserLocal,
    required this.callUpdateUser,
    required this.callLoginAuth,
  }) : super(LoginState()){
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChange);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginEmailChanged(LoginEmailChanged emailChanged, Emitter<LoginState> emit){
    emit(state.copyWith(
      email: emailChanged.email,
    ));
  }

  void _onLoginPasswordChange(LoginPasswordChanged passwordChanged, Emitter<LoginState> emit){
    emit(state.copyWith(
      password: passwordChanged.password
    ));
  }

  void _onLoginSubmitted(LoginSubmitted loginSubmitted, Emitter<LoginState> emit)async{
    emit(state.copyWith(formStatus: FormSubmitting())); // loading

    try{
    final _result = await callLoginAuth(AuthRequest(email: state.email, password: state.password));
      if(_result.isSuccess()){
        final fbToken = await FirebaseMessaging.instance.getToken();
        if(fbToken == null || fbToken.isEmpty){
          throw Exception("Error getting fcm token");
        }
        putUserLocal(_result.content!);

        final _resultFbUpdate = await callUpdateUser(fbToken);
        if(_resultFbUpdate.isSuccess()){
          if(_resultFbUpdate.content!){
            emit(state.copyWith(formStatus: SubmissionSuccess(),email: "", password: "", user: _result.content!));
          }else{
            putUserLocal(User.initial());
            emit(state.copyWith(formStatus: SubmissionFailed("Firebase token did not update.")));
          }
        }else{
          putUserLocal(User.initial());
          emit(state.copyWith(formStatus: SubmissionFailed("Firebase token did not update.")));
        }
      }else{
        emit(state.copyWith(formStatus: SubmissionFailed(_result.error.toString())));
      }
    }catch(error){
      emit(state.copyWith(formStatus: SubmissionFailed(error.toString())));
      logger.logError(error.toString());
    }
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
  }

}