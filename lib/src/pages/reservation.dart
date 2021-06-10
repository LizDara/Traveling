import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(246, 247, 249, 1),
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[Background(), FormReservation()],
          )),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _createBackground(),
        _createImage(),
      ],
    );
  }

  Widget _createBackground() {
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

  Container _createImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Image(
        image: AssetImage('assets/ticket.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class FormReservation extends StatefulWidget {
  const FormReservation({
    Key key,
  }) : super(key: key);

  @override
  _FormReservationState createState() => _FormReservationState();
}

class _FormReservationState extends State<FormReservation> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            _createTitle(),
            SizedBox(
              height: 10,
            ),
            _createDeparture(),
            SizedBox(
              height: 6,
            ),
            _createDestination(),
            SizedBox(
              height: 20,
            ),
            _createGoButton(context)
          ],
        )),
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Love at',
          style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
        ),
        Text(
          'First Flight',
          style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _createDeparture() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        color: Colors.white,
        child: TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              labelText: 'From',
              labelStyle: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              icon: Icon(
                Icons.flight_takeoff,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _createDestination() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        color: Colors.white,
        child: TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              labelText: 'To',
              labelStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              icon: Icon(
                Icons.flight_land,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _createGoButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'GO',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () => Navigator.pushNamed(context, 'details'),
            ),
          ),
        ),
      ],
    );
  }
}
