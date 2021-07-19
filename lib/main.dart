import 'package:flutter/material.dart';
import 'package:traveling/src/blocs/provider.dart';
import 'package:traveling/src/preferences/user_preferences.dart';
import 'package:traveling/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = new UserPreferences();
  await preferences.initPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flight',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES'),
        ],
        theme: _myTheme(),
        initialRoute: 'welcome',
        routes: getApplicationRoutes(),
      ),
    );
  }

  ThemeData _myTheme() {
    return ThemeData(
      focusColor: Color.fromRGBO(6, 6, 6, 1),
      cursorColor: Color.fromRGBO(6, 6, 6, 1),
      primaryColor: Color.fromRGBO(6, 6, 6, 1),
    );
  }
}
