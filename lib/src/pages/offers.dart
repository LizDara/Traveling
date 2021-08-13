import 'package:flutter/material.dart';
import 'package:traveling/src/models/flightOffer_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/models/ticketList_model.dart';
import 'package:traveling/src/providers/TicketProvider.dart';

class OffersPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final SearchTicket searchTicket =
        ModalRoute.of(context)!.settings.arguments as SearchTicket;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          FlightsList(searchTicket, scaffoldKey),
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

class FlightsList extends StatefulWidget {
  FlightsList(this.searchTicket, this.scaffoldKey);
  final SearchTicket searchTicket;
  final scaffoldKey;

  @override
  _FlightsListState createState() => _FlightsListState();
}

class _FlightsListState extends State<FlightsList> {
  List<TicketList> ticketList = [];

  final TicketProvider ticketProvider = new TicketProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ticketProvider.searchTickets(widget.searchTicket),
      builder:
          (BuildContext context, AsyncSnapshot<List<TicketList>> snapshot) {
        if (snapshot.hasData) {
          ticketList = snapshot.data!;
          return (ticketList.length == 0)
              ? Center(
                  child: Text(
                    'No se encontraron Boletos disponibles.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: ListView.builder(
                      itemCount: ticketList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 28),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _createItinerary(
                                      ticketList[index].itineraries),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        ticketList[index]
                                                .travelerPricings![0]
                                                .fareDetailsBySegment![0]
                                                .cabin ??
                                            '',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                210, 155, 134, 0.9),
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        child: FlatButton(
                                          child: Text(
                                            'BOB ' +
                                                (ticketList[index]
                                                        .price!
                                                        .grandTotal ??
                                                    '') +
                                                ' Reservar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          onPressed: () => _confirmTicket(
                                              context, ticketList[index]),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
            ),
          );
        }
      },
    );
  }

  Widget _createItinerary(List<Itinerary>? itineraries) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(6, 6, 6, 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    itineraries![0].segments![0].departure!.iataCode ?? '',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                        _getDuration(itineraries[0].duration ?? ''),
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
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(135, 134, 210, 0.9), width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    itineraries[0].segments![0].arrival!.iataCode ?? '',
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
                  _getDateTime(itineraries[0].segments![0].departure!.at ?? ''),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  _getDateTime(itineraries[0].segments![0].arrival!.at ?? ''),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
        (itineraries.length > 1)
            ? Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(6, 6, 6, 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          itineraries[1].segments![0].departure!.iataCode ?? '',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
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
                              _getDuration(itineraries[0].duration ?? ''),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(135, 134, 210, 0.9),
                                width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          itineraries[1].segments![0].arrival!.iataCode ?? '',
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
                        _getDateTime(
                            itineraries[1].segments![0].departure!.at ?? ''),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: Container()),
                      Text(
                        _getDateTime(
                            itineraries[1].segments![0].arrival!.at ?? ''),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
      ],
    );
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

  String _getDuration(String duration) {
    duration.replaceAll(new RegExp(r'P'), '');
    List<String> separateDuration = duration.split('T');
    String result = separateDuration[1].replaceAll(new RegExp(r'H'), 'h ');
    return result.replaceAll(new RegExp(r'M'), 'm ');
  }

  _confirmTicket(BuildContext context, TicketList ticketList) async {
    FlightOffer flightOffer = new FlightOffer();
    List<TicketList> tickets = [
      ticketList,
    ];
    Data data = new Data(type: 'flight-offers-pricing', flightOffers: tickets);
    flightOffer.data = data;

    final confirmOffer = await ticketProvider.confirmTicket(flightOffer);
    if (confirmOffer != null) {
      Navigator.of(context)
          .pushNamed('ticket', arguments: [confirmOffer, widget.searchTicket]);
    } else {
      _showMessage(
          'No se pudo encontrar la oferta seleccionada. Inténtelo nuevamente por favor.');
    }
  }

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
