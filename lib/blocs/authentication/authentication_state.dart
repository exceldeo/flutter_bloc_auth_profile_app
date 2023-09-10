part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class LoginState extends AuthenticationState {
  final RequestLogin requestLogin;

  LoginState({required this.requestLogin});

  @override
  List<Object> get props => [requestLogin.email, requestLogin.password];
}

class RegisterState extends AuthenticationState {
    final RequestRegister requestRegister;

  RegisterState({required this.requestRegister});

  @override
  List<Object> get props => [requestRegister.username, requestRegister.email, requestRegister.password];
}

class LogoutState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}