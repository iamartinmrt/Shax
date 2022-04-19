import 'package:core/core.dart';

import '../../../../models/entities/user.dart';

class LoginState {
  final User? user;
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.user,
    this.email = "",
    this.password = "",
    this.formStatus = const InitialFormStatus()
  });

  LoginState copyWith({
    String? email,
    String? password,
    User? user,
    FormSubmissionStatus? formStatus
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      formStatus: formStatus ?? this.formStatus,
    );
  }

}
