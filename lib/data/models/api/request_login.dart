class RequestLogin {
  final String email;
  final String password;

  RequestLogin({required this.email, required this.password});

  factory RequestLogin.fromJson(Map<String, dynamic> json) {
    return RequestLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}