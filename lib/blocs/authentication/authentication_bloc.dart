import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_app/data/models/api/request_login.dart';
import 'package:my_profile_app/data/models/api/request_register.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      await Future.delayed(Duration(seconds: 2));

      print("email ${event.requestLogin.email}");
      print("password ${event.requestLogin.password}");
      emit(LoginState(
          requestLogin: RequestLogin(
              email: event.requestLogin.email,
              password: event.requestLogin.password)));
    });
  }
}
