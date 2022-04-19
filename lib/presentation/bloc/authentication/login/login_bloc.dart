import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shax/domain/usecase/login_call_login_auth.dart';
import 'package:shax/domain/usecase/login_call_update_user.dart';
import 'package:shax/models/request/auth_request.dart';
import '../../../../models/entities/user.dart';
import 'bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{

  LoginCallLoginAuth callLoginAuth;
  LoginCallUpdateUser callUpdateUser;
  Box<User> hiveBox;
  ShaxLogger logger;

  LoginBloc({
    required this.logger,
    required this.hiveBox,
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
        hiveBox.put(ApiConstants.userInstance, _result.content!);
        // TODO : add firebase messaging to get deviceToken
        String fbToken = "Mamad";

        Map<String, String> map;
        if(Platform.isAndroid){
          map = <String, String>{
            "fb_token_android": fbToken,
          };
        }else {
          map = <String, String>{
            "fb_token_ios": fbToken,
          };
        }
        final _resultFbUpdate = await callUpdateUser(map);
        if(_resultFbUpdate.isSuccess()){
          if(_resultFbUpdate.content!){
            emit(state.copyWith(formStatus: SubmissionSuccess(),email: "", password: "", user: _result.content!));
          }else{
            hiveBox.put(ApiConstants.userInstance, const User(token: "", id: "", email: ""));
            emit(state.copyWith(formStatus: SubmissionFailed("Firebase token did not update.")));
          }
        }else{
          hiveBox.put(ApiConstants.userInstance, const User(token: "", id: "", email: ""));
          emit(state.copyWith(formStatus: SubmissionFailed("Firebase token did not update.")));
        }
      }else{
        emit(state.copyWith(formStatus: SubmissionFailed(_result.error.toString())));
      }
    }catch(error){
      emit(state.copyWith(formStatus: SubmissionFailed(error.toString())));
      logger.logError(error.toString());
    }
    // Future.delayed(const Duration(seconds: 2)).then((value) => {
    //   emit(state.copyWith(formStatus: const InitialFormStatus()))
    // });
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
  }

}