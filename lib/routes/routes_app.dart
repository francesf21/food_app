import 'package:flutter/material.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );

      case RoutesName.onboard:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnboardScreen(),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        );

      case RoutesName.register:
        return MaterialPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        );

      case RoutesName.resetPassowrd:
        return MaterialPageRoute(
          builder: (BuildContext context) => ResetPasswordScreen(),
        );

      case RoutesName.person:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PersonScreen(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );

      case RoutesName.search:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SearchScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
