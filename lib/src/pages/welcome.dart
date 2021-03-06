import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Welcome(),
                SizedBox(
                  height: 20,
                ),
                GetStarted()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(89, 72, 119, 1),
              Color.fromRGBO(149, 86, 135, 1)
            ]),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 7 / 11,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70,
      ),
      child: Stack(
        children: <Widget>[
          Text(
            'Vuela a cualquier parte del mundo con la aplicaión Volad Tours.',
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
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _createTitle(),
        SizedBox(
          height: 6,
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
          'Reserva de',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 30),
        ),
        Text(
          'Vuelos',
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
      onPressed: () => _nextPage(context),
      child: Text(
        'Empecemos',
        style: TextStyle(fontSize: 16),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Color.fromRGBO(6, 6, 6, 1),
      textColor: Colors.white,
    );
  }

  _nextPage(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final tokens = await userProvider.readToken();
    if (tokens[0] == '' && tokens[1] == '') {
      Navigator.of(context).pushReplacementNamed('signin');
    } else {
      Navigator.of(context).pushReplacementNamed('main');
    }
  }
}
