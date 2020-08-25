import 'package:cazdata_frontend/providers/theme.dart';
import 'package:cazdata_frontend/redux/index.dart';
import 'package:cazdata_frontend/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(CazdataApp());
}

class CazdataApp extends StatelessWidget {
  final Store<AppState> store = createStore();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, model, child) => StoreProvider(
          store: this.store,
          child: MaterialApp(
            title: 'Cazdata',
            theme: model.lightTheme,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generateRoute,
            onUnknownRoute: Routes.errorRoute,
            initialRoute: Routes.login,
          ),
        ),
      ),
    );
  }
}
