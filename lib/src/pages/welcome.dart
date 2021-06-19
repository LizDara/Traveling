import 'package:flutter/material.dart';
import 'package:traveling/src/preferences/user_preferences.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key key}) : super(key: key);

  final preferences = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Welcome(),
            SizedBox(
              height: 25,
            ),
            GetStarted(
              preferences: preferences,
            )
          ],
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 7 / 11,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(135, 134, 210, 0.3),
      ),
      child: Stack(
        children: <Widget>[
          Text(
            'Fly anywhere in the world with the Line mobile app.',
            style: TextStyle(fontSize: 17),
          ),
          Positioned(
              left: 10,
              top: 70,
              child: _createCircle(100, 'assets/aviones.jpeg')),
          Positioned(
              right: 10,
              top: 125,
              child: _createCircle(120, 'assets/aviones2.jpg')),
          Positioned(
              left: 3,
              bottom: 50,
              child: _createCircle(80, 'assets/aviones4.jpg')),
          Positioned(
            right: 35,
            bottom: 5,
            child: _createCircle(90, 'assets/aviones3.jpg'),
          )
        ],
      ),
    );
  }

  Widget _createCircle(double size, String path) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
      ),
      child: Image(
        image: AssetImage(path),
        fit: BoxFit.cover,
      ),
    );
  }
}

class GetStarted extends StatelessWidget {
  const GetStarted({Key key, @required this.preferences}) : super(key: key);

  final UserPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _createTitle(),
        SizedBox(
          height: 10,
        ),
        _createButton(context),
      ],
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tickets',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 30),
        ),
        Text(
          'booking',
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _createButton(BuildContext context) {
    return RaisedButton(
      onPressed: () =>
          Navigator.pushReplacementNamed(context, preferences.lastPage),
      child: Text(
        'Get Started',
        style: TextStyle(fontSize: 16),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Color.fromRGBO(6, 6, 6, 1),
      textColor: Colors.white,
    );
  }
}
