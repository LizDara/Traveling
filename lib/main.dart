import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/providers/UserProvider.dart';
import 'package:traveling/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:traveling/src/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
