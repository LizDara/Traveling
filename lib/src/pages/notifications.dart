import 'package:flutter/material.dart';
import 'package:traveling/src/objects/reservation.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(), Notifications()],
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

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<Reservation> reservations = new List();
  /*[
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Jan 29',
        destinationDate: 'Jan 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Business',
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
        typeClass: 'Business',
        isExpanded: false),
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Jan 29',
        destinationDate: 'Jan 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Business',
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
        typeClass: 'Business',
        isExpanded: false),
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Jan 29',
        destinationDate: 'Jan 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Business',
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
        typeClass: 'Business',
        isExpanded: false),
    new Reservation(
        from: 'Botswana',
        to: 'Bermudas',
        departure: 'TBS',
        destination: 'BER',
        time: '3h 40m',
        departureDate: 'Jan 29',
        destinationDate: 'Jan 30',
        departureHour: '20:00',
        destinationHour: '01:00',
        price: '226',
        flight: 'KC89',
        typeClass: 'Business',
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
        typeClass: 'Business',
        isExpanded: false),
  ];*/

  @override
  Widget build(BuildContext context) {
    return (reservations.length == 0)
        ? Center(
            child: Text(
              'No notifications.',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: reservations.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 14),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/pass.png'),
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Fligth ' +
                                reservations[index].flight +
                                ', bound for ' +
                                reservations[index].to,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            reservations[index].time +
                                ' to take off the airplane. Pack your bags.',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black54),
                            maxLines: 3,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
