part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {
  final RequestLogin requestLogin;

  LoginEvent({required this.requestLogin});

  @override
  List<Object> get props => [requestLogin.email, requestLogin.password];
}

class RegisterEvent extends AuthenticationEvent {
  final RequestRegister requestRegister;

  RegisterEvent({required this.requestRegister});

  @override
  List<Object> get props => [requestRegister.username, requestRegister.email, requestRegister.password];
}

class LogoutEvent extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoadingEvent extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
