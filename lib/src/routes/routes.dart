import 'package:flutter/material.dart';
import 'package:traveling/src/pages/details.dart';
import 'package:traveling/src/pages/home.dart';
import 'package:traveling/src/pages/reservation.dart';
import 'package:traveling/src/pages/signin.dart';
import 'package:traveling/src/pages/signup.dart';
import 'package:traveling/src/pages/ticket.dart';
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
  };
}
