import 'package:cazdata_frontend/ui/pages/login.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String homeRoute = "/";
const String loginRoute = "/login";

class Routes {
  static final homePage = "HOME_PAGE";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) {
            return ChangeNotifierProvider<BottomNavigationBarProvider>(
              child: BottomNavigationBarWidget(),
              create: (BuildContext context) => BottomNavigationBarProvider(),
            );
          },
        );

      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
