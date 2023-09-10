import 'package:my_profile_app/core/base/auth/model/auth_model.dart';
import 'package:my_profile_app/core/init/network/dio_manager.dart';

abstract class IAuthService {
  final DioManager dioManager;

  IAuthService(this.dioManager);

  Future<AuthModel?> login({
    required String email,
    required String password,
  });

  Future<AuthModel?> register({
    required String email,
    required String password,
    required String username,
  });
}
