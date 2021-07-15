import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[Background(), FormDetail()],
      ),
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
        Container(
          margin: EdgeInsets.fromLTRB(25, 40, 25, 25),
          child: Column(
            children: <Widget>[
              _createImage(),
              _createName(),
              _createFullName()
            ],
          ),
        ),
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

  Widget _createImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.flight_takeoff,
          size: 30,
          color: Colors.white,
        ),
        Expanded(
          child: Image(
            image: AssetImage('assets/segment_light.png'),
            fit: BoxFit.fill,
          ),
        ),
        Icon(
          Icons.flight_land,
          size: 30,
          color: Colors.white,
        )
      ],
    );
  }

  Widget _createName() {
    return Row(
      children: <Widget>[
        Text(
          'DHK',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          'SIN',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _createFullName() {
    return Row(
      children: <Widget>[
        Text(
          'Dhaka, Bangladesh',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          'Changi, Singapore',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class FormDetail extends StatefulWidget {
  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 7,
              ),
              FlightDetails(),
              SizedBox(
                height: 25,
              ),
              _createNextButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _createNextButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'SIGUIENTE',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () => Navigator.pushNamed(context, 'ticket')),
        )),
      ],
    );
  }
}

class FlightDetails extends StatelessWidget {
  const FlightDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createTitle(),
            SizedBox(
              height: 14,
            ),
            _createRoundTrip(),
            SizedBox(
              height: 6,
            ),
            _createDeparture(),
            SizedBox(
              height: 6,
            ),
            _createReturn(),
            SizedBox(
              height: 6,
            ),
            _createClass(),
            SizedBox(
              height: 6,
            ),
            _createPassenger(),
          ],
        ),
      ),
    );
  }

  Widget _createTitle() {
    return Text(
      'Detalles del Vuelo',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _createRoundTrip() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.sync,
          color: Color.fromRGBO(6, 6, 6, 1),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Viaje de Vuelta',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          child: Switch(
              activeColor: Color.fromRGBO(6, 6, 6, 1),
              value: true,
              onChanged: (value) {}),
        ),
      ],
    );
  }

  Widget _createDeparture() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              Icons.trip_origin,
              color: Color.fromRGBO(6, 6, 6, 1),
            ),
            Image(
              image: AssetImage('assets/line.png'),
              height: 20,
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '26 de Marzo 2020, 19:45',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'PARTIDA',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180), color: Colors.black26),
        )
      ],
    );
  }

  Widget _createReturn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              Icons.card_travel,
              color: Color.fromRGBO(6, 6, 6, 1),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '30 de Marzo 2020, 13:30',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'LLEGADA',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180), color: Colors.black26),
        )
      ],
    );
  }

  Widget _createClass() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              Icons.airline_seat_recline_extra,
              color: Color.fromRGBO(6, 6, 6, 1),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Ejecutivo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'CLASE',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180), color: Colors.black26),
        )
      ],
    );
  }

  Widget _createPassenger() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              Icons.person_outline,
              color: Color.fromRGBO(6, 6, 6, 1),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '2 Personas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'PASAJEROS',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Column(
          children: <Widget>[
            Container(
              width: 40,
              height: 38,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(12)),
                  color: Colors.black12),
              child: FlatButton(
                child: Text(
                  '‒',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              width: 40,
              height: 38,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(12)),
                  color: Colors.black12),
              child: FlatButton(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {},
              ),
            )
          ],
        )
      ],
    );
  }
}
