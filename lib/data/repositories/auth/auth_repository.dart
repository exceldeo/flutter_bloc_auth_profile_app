import 'package:dio/dio.dart';
import 'package:my_profile_app/data/models/api/request_login.dart';
import 'package:my_profile_app/data/models/api/request_register.dart';
import 'package:my_profile_app/utils/token_storqage.dart';

final key = '';

class AuthRepository {
  final Dio dio;
  AuthRepository(this.dio);

  Future<bool> login(String email, String password) async {
    try {
      final requestLogin = RequestLogin(email: email, password: password);
      final requestLoginJson = requestLogin.toJson();
      final response = await dio.post('/auth/login', data: requestLoginJson);
      if (response.statusCode == 200) {
        final token = response.data['token'] as String;
        await TokenStorage().persistToken(token);
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final requestRegister =
          RequestRegister(username: username, email: email, password: password);
      final requestRegisterJson = requestRegister.toJson();
      final response =
          await dio.post('/api/register', data: requestRegisterJson);
      return response.statusCode == 200;
    } catch (e) {
      // Handle error
      return false;
    }
  }

  Future<void> logout() async {
    await TokenStorage().deleteToken();
  }

  Future<bool> isSignedIn() async {
    final token = await TokenStorage().getToken();
    return token != null;
  }
}
