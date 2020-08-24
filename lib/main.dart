import 'package:cazdata_frontend/redux/index.dart';
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
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Keys.navKey,
        onGenerateRoute: Router.generateRoute,
        initialRoute: loginRoute,
        routes: {
          homeRoute: (context) {
            return BottomNavigationBarWidget();
          }
        },
        theme: ThemeData(primaryColor: primaryColor, accentColor: accentColor, fontFamily: 'Montserrat'),
      ),
    );
  }
}
