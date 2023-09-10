class AuthModel {
  String? token;
  String? username;

  AuthModel({
    this.token,
    this.username,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String?,
      username: json['username'] as String?,
    );
  }
}
