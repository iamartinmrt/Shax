class SignupEvent{}

class SignupEmailChanged extends SignupEvent{
  final String email;
  SignupEmailChanged(this.email);
}

class SignupPasswordChanged extends SignupEvent{
  final String password;
  SignupPasswordChanged(this.password);
}

class SignupRepeatedPasswordChanged extends SignupEvent{
  final String repeatedPassword;
  SignupRepeatedPasswordChanged(this.repeatedPassword);
}

class SignupSubmitted extends SignupEvent{}
