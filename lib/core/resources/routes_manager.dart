import 'package:flutter/material.dart';

import '../../features/home/presentation/screens/home_page.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'strings_manger.dart';

class Routes {
  Routes._();
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      //return MaterialPageRoute(builder: (_) => Temp());
      case Routes.homeRoute:
        return getView(HomePage());

      default:
        return noRouteFound();
    }
  }

  static PageRouteBuilder<dynamic> getView1(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, _) => screen,
      transitionDuration: Duration(seconds: 2),
      transitionsBuilder: (_, animation, _, child) {
        var tween = Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeIn));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static PageRouteBuilder<dynamic> getView(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, _) => screen,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (_, animation, _, child) {
        return ScaleTransition(scale: animation, child: child);
      },
    );
  }

  static Route<dynamic> noRouteFound() {
    return MaterialPageRoute(
      builder: (_) =>
          Scaffold(body: Center(child: Text(AppStrings.noRouteFound))),
    );
  }
}
