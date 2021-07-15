import 'package:flutter/material.dart';
import 'package:vacod/pages/authorization/forgot_password/forgot_password.dart';
import 'package:vacod/pages/authorization/login/login.dart';
import 'package:vacod/pages/authorization/sign_up/sign_up.dart';
import 'package:vacod/pages/home/home.dart';
import 'package:vacod/pages/house/create/create_house.dart';
import 'package:vacod/pages/house/edit/edit_house.dart';
import 'package:vacod/pages/house/house.dart';
import 'package:vacod/pages/room/create/create_room.dart';
import 'package:vacod/pages/room/room.dart';
import 'package:vacod/pages/service/create/create_service.dart';
import 'package:vacod/pages/service/edit/edit_service.dart';
import 'package:vacod/pages/service/service.dart';
import 'package:vacod/routes/transitions.dart';

class RouteGenerator {
  final String? routeName;

  RouteGenerator(this.routeName);
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    RouteGenerator route = RouteGenerator(settings!.name);
    final dynamic args = settings.arguments ?? {};
    switch (settings.name) {
      case LoginPage.route:
        return route.fade(LoginPage());
      case SignUpPage.route:
        return route.fade(SignUpPage());
      case ForgotPasswordPage.route:
        return route.fade(ForgotPasswordPage());
      case HousePage.route:
        return route.fade(HousePage());
      case CreateHousePage.route:
        return route.fade(CreateHousePage());
      case RoomPage.route:
        return route.fade(RoomPage());
      case CreateRoomPage.route:
        return route.fade(CreateRoomPage());
      case ServicePage.route:
        return route.fade(ServicePage());
      case CreateServicePage.route:
        return route.fade(CreateServicePage());
      case EditHousePage.route:
        final houseId = args['houseId'] as String;
        return route.fade(EditHousePage(
          houseID: houseId,
        ));
      case EditServicePage.route:
        final serviceID = args['serviceID'] as String;
        return route.fade(EditServicePage(
          serviceID: serviceID,
        ));
      default:
        return route.normal(HomePage());
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
