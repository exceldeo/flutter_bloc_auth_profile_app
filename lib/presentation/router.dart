import 'package:flutter/material.dart';
import 'package:my_profile_app/presentation/screens/Insterest/insterest_page.dart';
import 'package:my_profile_app/presentation/screens/editProfile/edit_profile_page.dart';
import 'package:my_profile_app/presentation/screens/home/home_page.dart';
import 'package:my_profile_app/presentation/screens/login/login_page.dart';
import 'package:my_profile_app/presentation/screens/register/register_page.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case EditProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => EditProfilePage());
      case InsterestPage.routeName:
        return MaterialPageRoute(builder: (_) => InsterestPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                ));
    }
  }
}
