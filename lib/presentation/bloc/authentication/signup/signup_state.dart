import 'package:core/core.dart';

class SignupState{
  final String email;
  final String password;
  final String repeatedPassword;
  final FormSubmissionStatus formStatus;

  SignupState({
    this.email = "",
    this.password = "",
    this.repeatedPassword = "",
    this.formStatus = const InitialFormStatus()
  });

  SignupState copyWith({
    String? email,
    String? password,
    String? repeatedPassword,
    FormSubmissionStatus? formStatus
  }){
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        repeatedPassword: repeatedPassword ?? this.repeatedPassword
    );
  }

}