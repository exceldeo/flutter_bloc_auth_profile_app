import 'dart:developer';
import 'dart:io';

import 'package:my_profile_app/core/base/auth/model/auth_model.dart';
import 'package:my_profile_app/core/init/cache/auth_cache_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_app/core/constants/enums/auth_enums.dart';
import '../service/interface_auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  final AuthCacheManager authCacheManager;

  AuthBloc(this.authService, this.authCacheManager)
      : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await authCacheManager.isLoggedIn()) {
          await authCacheManager.updateTokenFromStorage();
          emit(const AuthState.authenticated());
        } else {
          emit((await authCacheManager.isFirstEntry())
              ? const AuthState.firstEntry()
              : const AuthState.guest());
        }
      } on SocketException {
        emit(const AuthState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const AuthState.error(error: AuthError.unknown));
      }
    });

    on<LoginRequested>(
      (event, emit) async {
        final AuthModel? response = await authService.login(
          email: event.email,
          password: event.password,
        );
        if (response != null) {
          await authCacheManager.updateToken(response.token.toString());
          await authCacheManager.updateUsername(response.username.toString());
          await authCacheManager.updateLoggedIn(true);
          emit(const AuthState.authenticated());
        } else {
          add(LogoutRequested());
          emit(const AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(const AuthState.guest());
      } catch (_) {}
    });

    on<RegisterRequested>(
      (event, emit) async {
        final AuthModel? response = (await authService.register(
            email: event.email,
            password: event.password,
            username: event.username));
        if (response != null) {
          await authCacheManager.updateToken(response.token.toString());
          await authCacheManager.updateUsername(response.username.toString());
          await authCacheManager.updateLoggedIn(true);
          emit(const AuthState.authenticated());
        } else {
          add(LogoutRequested());
          emit(const AuthState.error(error: AuthError.unknown));
        }
      },
    );
  }
}
