import 'package:flutter/material.dart';
import 'package:traveling/src/models/itinerary_model.dart';
import 'package:traveling/src/models/reservationTravel_model.dart';
import 'package:traveling/src/providers/TravelProvider.dart';

class TravelsPage extends StatelessWidget {
  const TravelsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(149, 86, 135, 1),
      body: Stack(
        children: <Widget>[
          Background(),
          Tickets(),
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
    return Stack(
      children: <Widget>[
        _createBackground(),
        _createTitle(context),
        _createImage(),
      ],
    );
  }

  Widget _createBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white54,
    );
  }

  Widget _createTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 2 / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(89, 72, 119, 1), //594877
              Color.fromRGBO(149, 86, 135, 1),
            ]),
      ),
    );
  }

  Widget _createImage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'My flights',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
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
  final TravelProvider travelProvider = new TravelProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: travelProvider.getTravels(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ReservationTravel>> snapshot) {
        if (snapshot.hasData) {
          final travels = snapshot.data;
          return (travels.length == 0)
              ? Center(
                  child: Text(
                    'No hay Boletos.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                )
              : Container(
                  child: ListView.builder(
                    itemCount: travels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: (index == 0)
                            ? EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 8,
                                bottom: 10,
                                left: 24,
                                right: 24)
                            : EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 24),
                            child: Column(
                              children: <Widget>[
                                _createInformation(
                                    travels[index].itinerarios[0]),
                                (travels[index].itinerarios.length > 1)
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/line_light.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(),
                                (travels[index].itinerarios.length > 1)
                                    ? _createInformation(
                                        travels[index].itinerarios[1])
                                    : Container(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image(
                                    image: AssetImage('assets/line_light.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Precio: ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'BOB ' + travels[index].precio,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _createInformation(Itinerary itinerary) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.near_me,
                    color: Color.fromRGBO(89, 72, 119, 1),
                  ),
                  Image(
                    image: AssetImage('assets/line.png'),
                    color: Color.fromRGBO(89, 72, 119, 1),
                    height: 20,
                  ),
                  Icon(
                    Icons.room,
                    color: Color.fromRGBO(89, 72, 119, 1),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      itinerary.lugarSalida
                          .replaceAll(RegExp(' Department'), ''),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      _getDateTime(itinerary.fechaSalida),
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      itinerary.lugarLlegada
                          .replaceAll(RegExp(' Department'), ''),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      _getDateTime(itinerary.fechaLlegada),
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 80,
          width: 1.2,
          margin: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.black26,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Código Salida: ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    itinerary.salidaIataCodigo,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Código Llegada: ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    itinerary.llegadaIataCodigo,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Duración: ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    _getDuration(itinerary.duracion),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
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
