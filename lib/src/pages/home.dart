import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:traveling/src/models/promotion_model.dart';
import 'package:traveling/src/models/region_model.dart';
import 'package:traveling/src/models/reservationTravel_model.dart';
import 'package:traveling/src/providers/PromotionProvider.dart';
import 'package:traveling/src/providers/TravelProvider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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

class Details extends StatelessWidget {
  Details({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OfferSwiper(),
            SizedBox(
              height: 16,
            ),
            ReservationSwiper(),
          ],
        ),
      ),
    );
  }
}

class OfferSwiper extends StatelessWidget {
  OfferSwiper({Key? key}) : super(key: key);

  final PromotionProvider promotionProvider = new PromotionProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: promotionProvider.getPromotions(),
      builder: (BuildContext context, AsyncSnapshot<List<Promotion>> snapshot) {
        if (snapshot.hasData) {
          final promotions = snapshot.data;
          return (promotions!.length == 0)
              ? Container(
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: MediaQuery.of(context).size.height * 2 / 5,
                  child: Center(
                    child: Text(
                      'No hay Ofertas.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : Swiper(
                  itemWidth: MediaQuery.of(context).size.width * 2 / 3,
                  itemHeight: MediaQuery.of(context).size.height * 2 / 5,
                  itemCount: promotions.length,
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
                              child: Image.asset('assets/' +
                                  promotions[index]
                                      .llegada!
                                      .toLowerCase()
                                      .replaceAll(new RegExp(' '), '_')
                                      .replaceAll(new RegExp(','), '') +
                                  '.png'),
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Ofertas',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      promotions[index]
                                              .salida!
                                              .replaceAll(' Department', '') +
                                          ' -',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(6, 6, 6, 1),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      promotions[index]
                                          .llegada!
                                          .replaceAll(' Department', ''),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(6, 6, 6, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      promotions[index].descuento.toString() +
                                          '% Descuento',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(6, 6, 6, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _getDateTime(
                                              promotions[index].fechaInicio ??
                                                  '') +
                                          ' - ' +
                                          _getDateTime(
                                              promotions[index].fechaFin ?? ''),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color.fromRGBO(6, 6, 6, 0.4),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () =>
                                  _sendOffer(context, promotions[index]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.height * 2 / 5,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
              ),
            ),
          );
        }
      },
    );
  }

  String _getDateTime(String dateTime) {
    if (dateTime.length == 0) return "";
    List<String> separateDateTime = dateTime.split('T');
    List<String> date = separateDateTime[0].split('-');
    String result = '';
    switch (date[1]) {
      case "01":
        result += 'Ene ';
        break;
      case "02":
        result += 'Feb ';
        break;
      case "03":
        result += 'Mar ';
        break;
      case "04":
        result += 'Abr ';
        break;
      case "05":
        result += 'May ';
        break;
      case "06":
        result += 'Jun ';
        break;
      case "07":
        result += 'Jul ';
        break;
      case "08":
        result += 'Ago ';
        break;
      case "09":
        result += 'Sep ';
        break;
      case "10":
        result += 'Oct ';
        break;
      case "11":
        result += 'Nov ';
        break;
      case "12":
        result += 'Dic ';
        break;
    }
    result += date[2];
    return result;
  }

  _sendOffer(BuildContext context, Promotion promotion) {
    List<Region> regions = [
      new Region(
          isoRegion: promotion.salidaIsoCodigo,
          isoCountry: promotion.fechaInicio,
          name: promotion.salida),
      new Region(
          isoRegion: promotion.llegadaIsoCodigo,
          isoCountry: promotion.fechaFin,
          name: promotion.llegada),
    ];
    Navigator.of(context).pushNamed('details', arguments: regions);
  }
}

class ReservationSwiper extends StatelessWidget {
  ReservationSwiper({Key? key}) : super(key: key);

  final TravelProvider travelProvider = new TravelProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: travelProvider.getTravels(context),
      builder: (BuildContext context,
          AsyncSnapshot<List<ReservationTravel>> snapshot) {
        if (snapshot.hasData) {
          final travels = snapshot.data;
          return (travels!.length == 0)
              ? Container(
                  width: MediaQuery.of(context).size.width * 7 / 8,
                  height: MediaQuery.of(context).size.height * 4 / 11,
                  child: Center(
                    child: Text(
                      'No hay Vuelos Pendientes.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                )
              : Swiper(
                  itemWidth: MediaQuery.of(context).size.width * 7 / 8,
                  itemHeight: MediaQuery.of(context).size.height * 4 / 11,
                  itemCount: travels.length,
                  pagination: new SwiperPagination(),
                  layout: SwiperLayout.CUSTOM,
                  customLayoutOption: new CustomLayoutOption(
                          startIndex: -1, stateCount: 3)
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 28),
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
                                    travels[index]
                                            .itinerarios![0]
                                            .salidaIataCodigo ??
                                        '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            'assets/flight_light.png'),
                                        fit: BoxFit.fill,
                                        color: Colors.black26,
                                      ),
                                      Text(
                                        _getDuration(travels[index]
                                                .itinerarios![0]
                                                .duracion ??
                                            ''),
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
                                          color: Color.fromRGBO(
                                              135, 134, 210, 0.9),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    travels[index]
                                            .itinerarios![0]
                                            .llegadaIataCodigo ??
                                        '',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(135, 134, 210, 0.9),
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
                                  _getDateTime(travels[index]
                                          .itinerarios![0]
                                          .fechaSalida ??
                                      ''),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  _getDateTime(travels[index]
                                          .itinerarios![0]
                                          .fechaLlegada ??
                                      ''),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Ver Detalles',
                                  style: TextStyle(fontSize: 15),
                                ),
                                IconButton(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onPressed: () => Navigator.pushNamed(
                                        context, 'flight',
                                        arguments: travels[index])),
                                Expanded(child: Container()),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(210, 155, 134, 0.9),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Text(
                                    'BOB ' + (travels[index].precio ?? ''),
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
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 7 / 8,
            height: MediaQuery.of(context).size.height * 4 / 11,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
              ),
            ),
          );
        }
      },
    );
  }

  String _getDuration(String duration) {
    duration.replaceAll(new RegExp(r'P'), '');
    List<String> separateDuration = duration.split('T');
    String result = separateDuration[1].replaceAll(new RegExp(r'H'), 'h ');
    return result.replaceAll(new RegExp(r'M'), 'm ');
  }

  String _getDateTime(String dateTime) {
    if (dateTime.length == 0) return "";
    List<String> separateDateTime = dateTime.split('T');
    List<String> date = separateDateTime[0].split('-');
    List<String> time = separateDateTime[1].split(':');
    String result = '';
    switch (date[1]) {
      case "01":
        result += 'Ene ';
        break;
      case "02":
        result += 'Feb ';
        break;
      case "03":
        result += 'Mar ';
        break;
      case "04":
        result += 'Abr ';
        break;
      case "05":
        result += 'May ';
        break;
      case "06":
        result += 'Jun ';
        break;
      case "07":
        result += 'Jul ';
        break;
      case "08":
        result += 'Ago ';
        break;
      case "09":
        result += 'Sep ';
        break;
      case "10":
        result += 'Oct ';
        break;
      case "11":
        result += 'Nov ';
        break;
      case "12":
        result += 'Dic ';
        break;
    }
    result += date[2] + ', ' + time[0] + ':' + time[1];
    return result;
  }
}
