import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/ui/pages/login.dart';
import 'package:cazdata_frontend/ui/widget/bottom-navigation-bar.widget.dart';
import 'package:cazdata_frontend/util/keys.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';

import 'util/colors.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> store = createStore();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            /* set Status bar color in Android devices. */

            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/

            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Keys.navKey,
        routes: {
          Routes.homePage: (context) {
            return BottomNavigationBarWidget();
          }
        },
        title: 'CazData',
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: accentColor,
            fontFamily: 'Montserrat'),
        home: LoginPage(),
      ),
    );
  }
}
