import 'package:cazdata_frontend/models/journey/journey.dart';
import 'package:cazdata_frontend/ui/pages/about.dart';
import 'package:cazdata_frontend/ui/pages/configurator.dart';
import 'package:cazdata_frontend/ui/pages/details-journey.dart';
import 'package:cazdata_frontend/ui/pages/error.dart';
import 'package:cazdata_frontend/ui/pages/journey.dart';
import 'package:cazdata_frontend/ui/pages/login.dart';
import 'package:cazdata_frontend/ui/pages/main-page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const journey = '/journey';
  static const configurator = '/configurator';
  static const detailsJourney = '/details-journey';
  static const about = '/about';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic> args = routeSettings.arguments;

      switch (routeSettings.name) {
        case home:
          return MaterialPageRoute(settings: routeSettings, builder: (_) => MainPage());

        case login:
          return MaterialPageRoute(settings: routeSettings, builder: (_) => LoginPage());

        case journey:
          return MaterialPageRoute(settings: routeSettings, builder: (_) => JourneyPage());

        case configurator:
          return MaterialPageRoute(settings: routeSettings, builder: (_) => Configurator());

        case detailsJourney:
          final journey = args['journey'] as Journey;
          return MaterialPageRoute(settings: routeSettings, builder: (_) => DetailsJourney(journey: journey));

        case about:
          return MaterialPageRoute(settings: routeSettings, builder: (_) => AboutPage());

        default:
          return errorRoute(routeSettings);
      }
    } catch (_) {
      return errorRoute(routeSettings);
    }
  }

  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => ErrorScreen(),
    );
  }
}
