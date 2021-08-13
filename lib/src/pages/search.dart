import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(), FindTrip()],
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
    return Stack(
      children: <Widget>[_createBackground(), _createImage()],
    );
  }

  Container _createBackground() {
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

  Widget _createImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Image(image: AssetImage('assets/find_trip.png')),
      ],
    );
  }
}

class FindTrip extends StatelessWidget {
  const FindTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          _createTitle(),
          Expanded(child: Container()),
          _createNextButton(context),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "No Todos Podemos",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          "Quedarnos en Casa",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 14,
        ),
        Text(
          'Encuentra las mejores ofertas para tus viajes de negocio o vaciones.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _createNextButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
              color: Colors.white38, borderRadius: BorderRadius.circular(180)),
          child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () => Navigator.pushNamed(context, 'reservation')),
        )
      ],
    );
  }
}
