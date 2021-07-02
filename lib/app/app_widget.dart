import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/login/login_store.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends ModularState<AppWidget, UsuarioStore> {
  @override
  void initState() {
    super.initState();
    store.changeColor("0xff000000");
    getTheme().then((value) => store.themeColor = value);
  }

  Future<bool> changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('appTheme', '');
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('appTheme') ?? '0xff000000';
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nossa Casa',
        initialRoute: '/',
        theme: ThemeData(
            primaryColor: Color(int.parse(store.themeColor)),
            accentColor: Color(int.parse(store.themeColor)),
            colorScheme: ColorScheme(
                onError: Colors.black,
                primary: Color(int.parse(store.themeColor)),
                primaryVariant: Color(int.parse(store.themeColor)),
                secondary: Color(int.parse(store.themeColor)),
                onSecondary: Colors.white,
                onSurface: Color(int.parse(store.themeColor)),
                surface: Color(int.parse(store.themeColor)),
                brightness: Brightness.light,
                background: Color(int.parse(store.themeColor)),
                onPrimary: Colors.white,
                secondaryVariant: Color(int.parse(store.themeColor)),
                onBackground: Color(int.parse(store.themeColor)),
                error: Color(int.parse(store.themeColor))),
            sliderTheme: SliderThemeData(
                inactiveTrackColor: Colors.grey[300],
                thumbColor: Color(int.parse(store.themeColor)),
                activeTrackColor: Color(int.parse(store.themeColor)),
                valueIndicatorColor: Color(int.parse(store.themeColor))),
            buttonColor: Color(int.parse(store.themeColor)),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
              color: Color(int.parse(store.themeColor)),
            )),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Color(int.parse(store.themeColor)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(int.parse(store.themeColor)),
                ), //button color
                foregroundColor: MaterialStateProperty.all<Color>(
                  Color(0xffffffff),
                ), //text (and icon)
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Color(int.parse(store.themeColor)),
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white),
            ),
            fontFamily: GoogleFonts.architectsDaughter().fontFamily),
      ).modular(),
    );
  }
}
