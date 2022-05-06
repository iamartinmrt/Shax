import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shax/domain/usecase/signup_call_signup_auth.dart';
import 'package:shax/models/request/auth_request.dart';
import 'package:shax/presentation/bloc/authentication/signup/bloc.dart';

import '../../../../models/entities/app_data.dart';
import '../../../../models/entities/user.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState>{

  SignupCallSignupAuth signupCallSignupAuth;

  SignupBloc({
    required this.signupCallSignupAuth,
  }) : super(SignupState()){
    on<SignupEmailChanged>(_onSignupEmailChanged);
    on<SignupPasswordChanged>(_onSignupPasswordChanged);
    on<SignupRepeatedPasswordChanged>(_onSignupRepeatedPasswordChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  void _onSignupEmailChanged(SignupEmailChanged emailChanged, Emitter<SignupState> emit){
    emit(state.copyWith(email: emailChanged.email));
  }

  void _onSignupPasswordChanged(SignupPasswordChanged passwordChanged, Emitter<SignupState> emit){
    emit(state.copyWith(password: passwordChanged.password));
  }

  void _onSignupRepeatedPasswordChanged(SignupRepeatedPasswordChanged repeatedPasswordChanged, Emitter<SignupState> emit){
    emit(state.copyWith(repeatedPassword: repeatedPasswordChanged.repeatedPassword));
  }

  void _onSignupSubmitted(SignupSubmitted submitted, Emitter<SignupState> emit)async{
    emit(state.copyWith(formStatus: FormSubmitting()));
    try{
      final _result = await signupCallSignupAuth(AuthRequest(email: state.email, password: state.password));
      if(_result.isSuccess()){
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      }else{
        emit(state.copyWith(formStatus: SubmissionFailed(_result.error.toString())));
      }
    }catch(error){
      emit(state.copyWith(formStatus: SubmissionFailed(error.toString())));
    }
    await Future.delayed(const Duration(seconds: 2)).then((value) =>
        emit(state.copyWith(formStatus: const InitialFormStatus())));
  }

}