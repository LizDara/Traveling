import 'package:flutter/material.dart';
import 'package:traveling/src/models/itinerary_model.dart';
import 'package:traveling/src/models/reservationTravel_model.dart';

class FlightPage extends StatelessWidget {
  const FlightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as ReservationTravel;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(
            reservation: reservation,
          ),
          Detail(
            reservation: reservation,
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.reservation,
  }) : super(key: key);
  final ReservationTravel reservation;

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
          reservation.itinerarios![0].salidaIataCodigo ?? '',
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
          reservation.itinerarios![0].llegadaIataCodigo ?? '',
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
          reservation.itinerarios![0].lugarSalida!
              .replaceAll(new RegExp(r' Department'), ''),
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          reservation.itinerarios![0].lugarLlegada!
              .replaceAll(new RegExp(r' Department'), ''),
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class Detail extends StatefulWidget {
  Detail({required this.reservation});
  final ReservationTravel reservation;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 7,
            ),
            TicketDetails(
              reservation: widget.reservation,
            ),
            SizedBox(
              height: 25,
            ),
            _createDoneButton(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDoneButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              'LISTO',
              style: TextStyle(fontSize: 16),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color.fromRGBO(6, 6, 6, 1),
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacementNamed('main'),
          ),
        )),
      ],
    );
  }
}

class TicketDetails extends StatefulWidget {
  TicketDetails({Key? key, required this.reservation}) : super(key: key);
  final ReservationTravel reservation;

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          _createImage(),
          _createDetail(context),
        ],
      ),
    );
  }

  Widget _createImage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Image(
        image: AssetImage('assets/flight.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _createDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 9,
          ),
          _createTicketPrice(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Image(image: AssetImage('assets/line_light.png')),
          ),
          FlightDetail(
            itinerary: widget.reservation.itinerarios![0],
          ),
          (widget.reservation.itinerarios!.length > 1)
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image(
                        image: AssetImage('assets/line_light.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 14,
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(145, 86, 138, 1),
                            ),
                            color: Color.fromRGBO(145, 86, 138, 1),
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(180),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: 14,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(143, 87, 149, 1),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(180),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Container(),
          (widget.reservation.itinerarios!.length > 1)
              ? FlightDetail(
                  itinerary: widget.reservation.itinerarios![1],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _createTicketPrice() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Precio del Boleto',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'BOB ' + (widget.reservation.precio ?? ''),
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FlightDetail extends StatelessWidget {
  const FlightDetail({Key? key, required this.itinerary}) : super(key: key);
  final Itinerary itinerary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Partida',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                _getDateTime(itinerary.fechaSalida ?? ''),
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Llegada',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                _getDateTime(itinerary.fechaLlegada ?? ''),
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'C??digo Salida',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                itinerary.salidaIataCodigo ?? '',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'C??digo Llegada',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                itinerary.llegadaIataCodigo ?? '',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Duraci??n',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                _getDuration(itinerary.duracion ?? ''),
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Clase',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'ECON',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDuration(String duration) {
    duration.replaceAll(new RegExp(r'P'), '');
    List<String> separateDuration = duration.split('T');
    String result = separateDuration[1].replaceAll(new RegExp(r'H'), 'h ');
    return result.replaceAll(new RegExp(r'M'), 'm ');
  }

  String _getDateTime(String dateTime) {
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
