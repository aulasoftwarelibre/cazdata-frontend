import 'package:cazdata_frontend/util/style.dart';
import 'package:flutter/material.dart';

enum Themes { light }

final Map<Themes, ThemeData> _themeData = {Themes.light: Style.light};

class ThemeProvider with ChangeNotifier {
  static Themes _theme = Themes.light;

  ThemeProvider() {
    init();
  }

  Themes get theme => _theme;

  set theme(Themes theme) {
    _theme = theme;
    notifyListeners();
  }

  ThemeData get lightTheme => _themeData[Themes.light];

  Future<void> init() async {
    theme = Themes.values[0];
  }
}
