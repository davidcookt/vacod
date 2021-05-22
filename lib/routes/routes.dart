import 'package:flutter/material.dart';
import 'package:vacod/pages/authorization/forgot_password/forgot_password.dart';
import 'package:vacod/pages/authorization/login/login.dart';
import 'package:vacod/pages/authorization/sign_up/sign_up.dart';
import 'package:vacod/routes/transitions.dart';

class RouteGenerator {
  final String routeName;

  RouteGenerator(this.routeName);
  static Route<dynamic> generateRoute(RouteSettings settings) {
    RouteGenerator route = RouteGenerator(settings.name);
    final dynamic args = settings.arguments ?? {};
    switch (settings.name) {
      case LoginPage.route:
        return route.fade(LoginPage());
      case SignUpPage.route:
        return route.fade(SignUpPage());
      case ForgotPasswordPage.route:
        return route.fade(ForgotPasswordPage());
      default:
      // return route.normal(HomePage());
    }
  }

  cancelBack(Widget widget) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) =>
            WillPopScope(child: widget, onWillPop: () async => false));
  }

  normal(Widget widget) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }

  fade(Widget widget) {
    return FadeRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }

  zoom(Widget widget) {
    return ZoomRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }

  slide(Widget widget) {
    return SlideRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => widget,
    );
  }
}
