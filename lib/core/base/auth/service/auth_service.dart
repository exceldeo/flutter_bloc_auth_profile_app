import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_profile_app/core/base/auth/model/auth_model.dart';
import 'package:my_profile_app/core/base/auth/model/login_model.dart';
import 'package:my_profile_app/core/base/auth/model/register_model.dart';
import 'package:my_profile_app/core/base/auth/service/interface_auth_service.dart';
import 'package:my_profile_app/core/constants/enums/network_enums.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);
  @override
  Future<AuthModel?> login({
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
        return AuthModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  Future<AuthModel?> register({
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
        return AuthModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
