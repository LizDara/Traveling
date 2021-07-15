import 'package:flutter/material.dart';
import 'package:traveling/src/objects/reservation.dart';

class TravelsPage extends StatelessWidget {
  const TravelsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(), Tickets()],
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
              Color.fromRGBO(89, 72, 119, 1), //594877
              Color.fromRGBO(149, 86, 135, 1)
            ]),
      ),
    );
  }

  Widget _createImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Container()),
              Container(
                height: 70,
                width: 70,
                child: Image(
                  image: AssetImage('assets/woman.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'My flights',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class Tickets extends StatefulWidget {
  Tickets({Key key}) : super(key: key);

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  final List<Reservation> reservations = //new List();
      [
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Ene 29',
        destinationDate: 'Ene 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Ejecutivo',
        isExpanded: false),
    new Reservation(
        from: 'Dhaka',
        to: 'Singapore',
        departure: 'DHK',
        destination: 'SIN',
        time: '6h 10m',
        departureDate: 'Mar 26',
        destinationDate: 'Mar 27',
        departureHour: '19:45',
        destinationHour: '01:55',
        price: '695',
        flight: 'CK88',
        typeClass: 'Ejecutivo',
        isExpanded: false),
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Ene 29',
        destinationDate: 'Ene 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Ejecutivo',
        isExpanded: false),
    new Reservation(
        from: 'Dhaka',
        to: 'Singapore',
        departure: 'DHK',
        destination: 'SIN',
        time: '6h 10m',
        departureDate: 'Mar 26',
        destinationDate: 'Mar 27',
        departureHour: '19:45',
        destinationHour: '01:55',
        price: '695',
        flight: 'CK88',
        typeClass: 'Ejecutivo',
        isExpanded: false),
  ];

  @override
  Widget build(BuildContext context) {
    return (reservations.length == 0)
        ? Center(
            child: Text(
              'No hay Boletos.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          )
        : Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(210, 155, 134, 0.3)))),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              reservations[index].departure,
                              style: TextStyle(
                                fontSize: 28,
                                color: Color.fromRGBO(210, 155, 134, 0.9),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              reservations[index].from,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(6, 6, 6, 0.7)),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              'FECHA',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromRGBO(6, 6, 6, 0.55),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              reservations[index].departureDate +
                                  ' ' +
                                  reservations[index].departureHour,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(6, 6, 6, 0.7)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.flight_takeoff,
                                color: Color.fromRGBO(210, 155, 134, 0.9),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                reservations[index].time,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              reservations[index].destination,
                              style: TextStyle(
                                fontSize: 28,
                                color: Color.fromRGBO(210, 155, 134, 0.9),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              reservations[index].to,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(6, 6, 6, 0.7)),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              'NÚMERO DE VUELO',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color.fromRGBO(6, 6, 6, 0.55),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              reservations[index].flight,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(6, 6, 6, 0.7)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                /*return ExpansionPanelList(
            animationDuration: Duration(seconds: 1),
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(reservations[index].from +
                        ' ' +
                        reservations[index].to),
                  );
                },
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(reservations[index].departureDate),
                      Text(reservations[index].destinationDate)
                    ],
                  ),
                ),
                isExpanded: reservations[index].isExpanded,
              ),
            ],
            expansionCallback: (int item, bool isExpanded) {
              setState(() {
                reservations[index].isExpanded =
                    !reservations[index].isExpanded;
              });
            },
          );*/
              },
            ),
          );
  }
}
