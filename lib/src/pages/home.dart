import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:traveling/src/objects/offer.dart';
import 'package:traveling/src/objects/reservation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Details(),
        ],
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

class Details extends StatelessWidget {
  Details({
    Key key,
  }) : super(key: key);

  final List<Offer> offers = new List();
  /*[
    new Offer(
        city: 'Dubai',
        price: '128',
        hour: '01:00',
        date: 'Feb 01',
        image: 'assets/dubai.png'),
    new Offer(
        city: 'Venice',
        price: '178',
        hour: '11:35',
        date: 'Feb 02',
        image: 'assets/venice.png')
  ];*/

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
        typeClass: 'Business'),
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
        typeClass: 'Business')
  ];*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OfferSwiper(
              offers: offers,
            ),
            SizedBox(
              height: 24,
            ),
            ReservationSwiper(
              reservations: reservations,
            ),
          ],
        ),
      ),
    );
  }
}

class OfferSwiper extends StatelessWidget {
  OfferSwiper({Key key, @required this.offers}) : super(key: key);

  final List<Offer> offers;

  @override
  Widget build(BuildContext context) {
    return (offers.length == 0)
        ? Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Center(
              child: Text(
                'No offers.',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          )
        : Swiper(
            itemWidth: MediaQuery.of(context).size.width * 2 / 3,
            itemHeight: MediaQuery.of(context).size.height * 2 / 5,
            itemCount: offers.length,
            pagination: new SwiperPagination(),
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(offers[index].image),
                      ),
                      Container(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Offer',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              offers[index].city,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromRGBO(6, 6, 6, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              r'From $ ' + offers[index].price,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(6, 6, 6, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              offers[index].hour + ' ' + offers[index].date,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(6, 6, 6, 0.2),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class ReservationSwiper extends StatelessWidget {
  ReservationSwiper({Key key, @required this.reservations}) : super(key: key);

  final List<Reservation> reservations;

  @override
  Widget build(BuildContext context) {
    return (reservations.length == 0)
        ? Container(
            width: MediaQuery.of(context).size.width * 7 / 8,
            height: MediaQuery.of(context).size.height * 4 / 11,
            child: Center(
              child: Text(
                'No pending flights.',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          )
        : Swiper(
            itemWidth: MediaQuery.of(context).size.width * 7 / 8,
            itemHeight: MediaQuery.of(context).size.height * 4 / 11,
            itemCount: reservations.length,
            pagination: new SwiperPagination(),
            layout: SwiperLayout.CUSTOM,
            customLayoutOption:
                new CustomLayoutOption(startIndex: -1, stateCount: 3)
                    .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
              new Offset(-370.0, -40.0),
              new Offset(0.0, 0.0),
              new Offset(370.0, -40.0)
            ]),
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 22, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(6, 6, 6, 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              reservations[index].departure,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/flight_light.png'),
                                  fit: BoxFit.fill,
                                  color: Colors.black26,
                                ),
                                Text(
                                  reservations[index].time,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(6, 6, 6, 1),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 22, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(135, 134, 210, 0.9),
                                    width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              reservations[index].destination,
                              style: TextStyle(
                                  color: Color.fromRGBO(135, 134, 210, 0.9),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            reservations[index].departureDate +
                                ', ' +
                                reservations[index].departureHour,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          Expanded(child: Container()),
                          Text(
                            reservations[index].destinationDate +
                                ', ' +
                                reservations[index].destinationHour,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: <Widget>[
                          Text(
                            'Show details',
                            style: TextStyle(fontSize: 15),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () =>
                                  Navigator.pushNamed(context, 'ticket')),
                          Expanded(child: Container()),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(210, 155, 134, 0.9),
                                borderRadius: BorderRadius.circular(14)),
                            child: Text(
                              r'$ ' + reservations[index].price + ' Book',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
