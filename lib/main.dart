import 'dart:io';

import 'package:my_profile_app/core/base/auth/service/auth_service.dart';
import 'package:my_profile_app/core/base/profile/bloc/profile_bloc.dart';
import 'package:my_profile_app/core/base/profile/service/profile_service.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/constants/app/string_constants.dart';
import 'package:my_profile_app/core/init/cache/auth_cache_manager.dart';
import 'package:my_profile_app/core/init/cache/profile_cache_manager.dart';
import 'package:my_profile_app/core/init/network/dio_manager.dart';
import 'package:my_profile_app/view/auth/login_view.dart';
import 'package:my_profile_app/view/auth/register_view.dart';
import 'package:my_profile_app/view/auth/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_app/view/home/home_view.dart';
import 'package:my_profile_app/view/insterest/create_view.dart';

import 'core/base/auth/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            AuthService(DioManager.instance),
            AuthCacheManager(),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            ProfileService(DioManager.instance),
            ProfileCacheManager(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.primary,
      ),
      initialRoute: '/splash',
      routes: {
        '/login': (_) => const LoginView(),
        '/register': (_) => const RegisterView(),
        '/splash': (_) => const SplashView(),
        '/': (_) => const HomeView(),
        '/interests/create': (_) => const CreateInsterestsView(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
