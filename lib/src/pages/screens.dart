import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:traveling/src/pages/home.dart';
import 'package:traveling/src/pages/notifications.dart';
import 'package:traveling/src/pages/profile.dart';
import 'package:traveling/src/pages/search.dart';
import 'package:traveling/src/pages/travels.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    TravelsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeScaleTransition(
          animation: primaryAnimation,
          child: child,
        ),
        duration: Duration(seconds: 1, milliseconds: 40),
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Color.fromRGBO(149, 86, 135, 0.7),
        selectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Inicio',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Viajar',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text(
              'Notificación',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            title: Text(
              'Boletos',
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Perfil',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
