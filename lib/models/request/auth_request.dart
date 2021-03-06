/// A data class to save email and password

class AuthRequest{

  final String email;
  final String password;

  AuthRequest({required this.email, required this.password});

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };

}