import 'package:flutter/material.dart';
import 'package:traveling/src/models/region_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/providers/TicketProvider.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Region> regions =
        ModalRoute.of(context).settings.arguments as List<Region>;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(
            departure: regions[0],
            destination: regions[1],
          ),
          FormDetail(regions[0], regions[1])
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key key,
    this.departure,
    this.destination,
  }) : super(key: key);

  final Region departure;
  final Region destination;

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
              _createFullName(context)
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
          departure.isoRegion,
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
          destination.isoRegion,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _createFullName(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          departure.name.replaceAll(new RegExp(r' Department'), ''),
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          destination.name.replaceAll(new RegExp(r' Department'), ''),
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
  const FormDetail(this.departure, this.destination);
  final Region departure;
  final Region destination;
  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  final formKey = GlobalKey<FormState>();
  final SearchTicket searchTicket = new SearchTicket();
  final TicketProvider ticketProvider = new TicketProvider();

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
              FlightDetails(searchTicket),
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
              onPressed: () => _searchTickets(context)),
        )),
      ],
    );
  }

  _searchTickets(BuildContext context) {
    searchTicket.fromIsoRegion = widget.departure.isoRegion;
    searchTicket.toIsoRegion = widget.destination.isoRegion;
    //final resultTickets = await ticketProvider.searchTickets(searchTicket);
    Navigator.pushNamed(context, 'flights', arguments: searchTicket);
  }
}

class FlightDetails extends StatefulWidget {
  const FlightDetails(this.searchTicket);
  final SearchTicket searchTicket;

  @override
  _FlightDetailsState createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  bool isRoundTrip = false;
  String departureDate = '26 de Marzo 2020, 19:45';
  String destinationDate = '30 de Marzo 2020, 13:30';
  String seatClass = 'Ejecutivo';
  List<String> options = ['Ejecutivo', 'Económico'];
  int passengers = 1;

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
              value: isRoundTrip,
              onChanged: (value) {
                setState(() {
                  isRoundTrip = value;
                  widget.searchTicket.roundTrip = value;
                });
              }),
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
            (isRoundTrip)
                ? Image(
                    image: AssetImage('assets/line.png'),
                    height: 20,
                  )
                : Container(),
          ],
        ),
        (isRoundTrip)
            ? SizedBox(
                width: 5,
              )
            : Container(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                departureDate,
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
          clipBehavior: Clip.antiAlias,
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180), color: Colors.black26),
          child: FlatButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectDate(context, true);
            },
            child: null,
          ),
        )
      ],
    );
  }

  _selectDate(BuildContext context, bool isDeparture) async {
    DateTime now = new DateTime.now();
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(now.year),
      firstDate: new DateTime(now.year),
      lastDate: new DateTime(now.year + 1),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked.toString().substring(0, 10);
          widget.searchTicket.fromDateRange =
              picked.toString().substring(0, 10);
        } else {
          destinationDate = picked.toString().substring(0, 10);
          widget.searchTicket.toDateRange = picked.toString().substring(0, 10);
        }
      });

      _selectTime(context, isDeparture);
    }
  }

  _selectTime(BuildContext context, bool isDeparture) async {
    TimeOfDay now = new TimeOfDay.now();
    TimeOfDay picked = await showTimePicker(context: context, initialTime: now);
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate += ' ' +
              ((picked.hour < 10)
                  ? '0' + picked.hour.toString()
                  : picked.hour.toString()) +
              ':' +
              ((picked.minute < 10)
                  ? '0' + picked.minute.toString()
                  : picked.minute.toString()) +
              ':00';
          widget.searchTicket.fromTimeRange = ((picked.hour < 10)
                  ? '0' + picked.hour.toString()
                  : picked.hour.toString()) +
              ':' +
              ((picked.minute < 10)
                  ? '0' + picked.minute.toString()
                  : picked.minute.toString()) +
              ':00';
        } else {
          destinationDate += ' ' +
              ((picked.hour < 10)
                  ? '0' + picked.hour.toString()
                  : picked.hour.toString()) +
              ':' +
              ((picked.minute < 10)
                  ? '0' + picked.minute.toString()
                  : picked.minute.toString()) +
              ':00';
          widget.searchTicket.toTimeRange = ((picked.hour < 10)
                  ? '0' + picked.hour.toString()
                  : picked.hour.toString()) +
              ':' +
              ((picked.minute < 10)
                  ? '0' + picked.minute.toString()
                  : picked.minute.toString()) +
              ':00';
        }
      });
    }
  }

  Widget _createReturn() {
    return (isRoundTrip)
        ? Row(
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
                      destinationDate,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                clipBehavior: Clip.antiAlias,
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: Colors.black26),
                child: FlatButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context, false);
                  },
                  child: null,
                ),
              )
            ],
          )
        : Container();
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
                seatClass,
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
          clipBehavior: Clip.antiAlias,
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(180), color: Colors.black26),
          child: FlatButton(
            onPressed: () => _showSeatClass(context),
            child: null,
          ),
        )
      ],
    );
  }

  _showSeatClass(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Clase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Seleccione el tipo de clase.'),
                _createClassList()
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Listo'),
              ),
            ],
          );
        });
  }

  Widget _createClassList() {
    return DropdownButton(
        value: seatClass,
        items: _getOptions(),
        onChanged: (opt) {
          setState(() {
            seatClass = opt;
            print(opt);
          });
        });
  }

  List<DropdownMenuItem<String>> _getOptions() {
    List<DropdownMenuItem<String>> list = new List();
    options.forEach((option) {
      list.add(DropdownMenuItem(
        child: Text(option),
        value: option,
      ));
    });
    return list;
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
                passengers.toString() +
                    ((passengers == 1) ? ' Persona' : ' Personas'),
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
                onPressed: () {
                  if (passengers > 1) {
                    setState(() {
                      passengers--;
                      widget.searchTicket.travelersNumbers = passengers;
                    });
                  }
                },
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
                onPressed: () {
                  if (passengers < 10) {
                    setState(() {
                      passengers++;
                      widget.searchTicket.travelersNumbers = passengers;
                    });
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
