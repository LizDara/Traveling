import 'package:flutter/material.dart';
import 'package:traveling/src/pages/account.dart';
import 'package:traveling/src/pages/changePassword.dart';
import 'package:traveling/src/pages/details.dart';
import 'package:traveling/src/pages/home.dart';
import 'package:traveling/src/pages/notifications.dart';
import 'package:traveling/src/pages/profile.dart';
import 'package:traveling/src/pages/reservation.dart';
import 'package:traveling/src/pages/screens.dart';
import 'package:traveling/src/pages/search.dart';
import 'package:traveling/src/pages/signin.dart';
import 'package:traveling/src/pages/signup.dart';
import 'package:traveling/src/pages/ticket.dart';
import 'package:traveling/src/pages/travels.dart';
import 'package:traveling/src/pages/welcome.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'welcome': (BuildContext context) => WelcomePage(),
    'signin': (BuildContext context) => SignInPage(),
    'signup': (BuildContext context) => SignUpPage(),
    'reservation': (BuildContext context) => ReservationPage(),
    'details': (BuildContext context) => DetailsPage(),
    'ticket': (BuildContext context) => TicketPage(),
    'home': (BuildContext context) => HomePage(),
    'main': (BuildContext context) => MainScreen(),
    'search': (BuildContext context) => SearchPage(),
    'profile': (BuildContext context) => ProfilePage(),
    'account': (BuildContext context) => AccountPage(),
    'password': (BuildContext context) => ChangePasswordPage(),
    'travels': (BuildContext context) => TravelsPage(),
    'notifications': (BuildContext context) => NotificationsPage(),
  };
}
