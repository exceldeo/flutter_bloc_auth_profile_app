import 'dart:async';

import 'package:my_profile_app/core/constants/enums/icon_enums.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:my_profile_app/core/extensions/image_extensions.dart';
import 'package:my_profile_app/core/init/cache/auth_cache_manager.dart';
import 'package:my_profile_app/core/utils/navigate_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_profile_app/core/base/auth/bloc/auth_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AuthBloc authBloc;
  late StreamSubscription authStream;
  late AnimationController _controller;
  late bool isLogin;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>()..add(AppStarted());

    /// For [animation]
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    authStream = authBloc.stream.listen((state) {
      Future.delayed(const Duration(seconds: 2))
          .then((_) => AuthCacheManager().isLoggedIn().then((value) {
                isLogin = value;
                if (isLogin) {
                  NavigateUtil().navigatePageClear(context, '/');
                } else {
                  NavigateUtil().navigatePageClear(context, '/login');
                }
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          IconEnums.appLogo.iconName.toPng,
          height: context.dynamicHeight(0.2),
          width: context.dynamicWidth(0.9),
        ),
      ),
    );
  }

  @override
  void dispose() {
    authStream.cancel();
    _controller.dispose();
    super.dispose();
  }
}
