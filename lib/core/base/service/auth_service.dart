import 'dart:io';

import 'package:my_profile_app/core/base/model/auth_model.dart';
import 'package:my_profile_app/core/base/model/login_model.dart';
import 'package:my_profile_app/core/base/model/register_model.dart';
import 'package:my_profile_app/core/base/service/interface_auth_service.dart';
import 'package:my_profile_app/core/constants/enums/network_enums.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);
  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dioManager.dio.post(
        NetworkEnums.login.path,
        data: LoginModel(
          email: email,
          password: password,
        ).toJson(),
      );

      if (response.statusCode == HttpStatus.created) {
        return AuthModel.fromJson(response.data).token;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String?> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      var response = await dioManager.dio.post(
        NetworkEnums.register.path,
        data: RegisterModel(
          email: email,
          password: password,
          username: username,
        ).toJson(),
      );

      if (response.statusCode == HttpStatus.created) {
        return AuthModel.fromJson(response.data).token;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
