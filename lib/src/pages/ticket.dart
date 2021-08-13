import 'package:flutter/material.dart';
import 'package:traveling/src/models/acceptOffer_model.dart';
import 'package:traveling/src/models/confirmOffer_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/models/ticketList_model.dart';
import 'package:traveling/src/models/traveler_model.dart';
import 'package:traveling/src/providers/TicketProvider.dart';

class TicketPage extends StatelessWidget {
  TicketPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final dataResult = ModalRoute.of(context)!.settings.arguments as List;

    final ConfirmOffer confirmOffer = dataResult[0] as ConfirmOffer;
    final SearchTicket searchTicket = dataResult[1] as SearchTicket;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(
            searchTicket: searchTicket,
          ),
          Detail(
            confirmOffer: confirmOffer,
            searchTicket: searchTicket,
            scaffoldKey: scaffoldKey,
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.searchTicket,
  }) : super(key: key);
  final SearchTicket searchTicket;

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
          searchTicket.fromIsoRegion ?? '',
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
          searchTicket.toIsoRegion ?? '',
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
          searchTicket.fromName!.replaceAll(new RegExp(r' Department'), ''),
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          searchTicket.toName!.replaceAll(new RegExp(r' Department'), ''),
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
  Detail(
      {required this.confirmOffer,
      required this.searchTicket,
      this.scaffoldKey});
  final ConfirmOffer confirmOffer;
  final SearchTicket searchTicket;
  final scaffoldKey;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final TicketProvider ticketProvider = new TicketProvider();
  AcceptOffer acceptOffer = new AcceptOffer();
  List<Traveler> travelers = [];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _setTravelers();
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
              searchTicket: widget.searchTicket,
              confirmOffer: widget.confirmOffer,
              formKey: formKey,
              acceptOffer: acceptOffer,
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

  _setTravelers() {
    for (int index = 0;
        index < (widget.searchTicket.travelersNumbers ?? 0);
        index++) {
      travelers.add(new Traveler(
          id: (index + 1).toString(),
          gender: 'FEMALE',
          contact: new Contact(),
          name: new Name()));
    }
    Data data = new Data(type: 'flight-order', travelers: travelers);
    acceptOffer.data = data;
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
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();
              _acceptOffer(context);
            },
          ),
        )),
      ],
    );
  }

  _acceptOffer(BuildContext context) async {
    acceptOffer.data!.flightOffers = widget.confirmOffer.data!.flightOffers;
    for (Itinerary itinerary
        in (acceptOffer.data!.flightOffers![0].itineraries ?? [])) {
      itinerary.duration = itinerary.segments![0].duration;
    }

    final result = await ticketProvider.acceptTicket(acceptOffer, context);
    if (result) {
      Navigator.of(context).pushReplacementNamed('main');
    } else {
      _showMessage(
          'No se pudo enviar los datos de los pasajeros. Inténtelo nuevamente por favor.');
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

class TicketDetails extends StatefulWidget {
  TicketDetails(
      {Key? key,
      required this.confirmOffer,
      this.formKey,
      required this.searchTicket,
      required this.acceptOffer})
      : super(key: key);
  final SearchTicket searchTicket;
  final ConfirmOffer confirmOffer;
  final formKey;

  final AcceptOffer acceptOffer;

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
        children: <Widget>[_createImage(), _createDetail(context)],
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
            itinerary:
                widget.confirmOffer.data!.flightOffers![0].itineraries![0],
            fareDetailsBySegment: widget.confirmOffer.data!.flightOffers![0]
                .travelerPricings![0].fareDetailsBySegment![0],
          ),
          (widget.confirmOffer.data!.flightOffers![0].itineraries!.length > 1)
              ? SizedBox(
                  height: 28,
                )
              : Container(),
          (widget.confirmOffer.data!.flightOffers![0].itineraries!.length > 1)
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
          (widget.confirmOffer.data!.flightOffers![0].itineraries!.length > 1)
              ? FlightDetail(
                  itinerary: widget
                      .confirmOffer.data!.flightOffers![0].itineraries![1],
                  fareDetailsBySegment: widget
                      .confirmOffer
                      .data!
                      .flightOffers![0]
                      .travelerPricings![0]
                      .fareDetailsBySegment![1],
                )
              : Container(),
          SizedBox(
            height: 28,
          ),
          Stack(
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
          ),
          ListPassengers(
            formKey: widget.formKey,
            searchTicket: widget.searchTicket,
            acceptOffer: widget.acceptOffer,
          ),
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
                r'BOB ' +
                    (widget.confirmOffer.data!.flightOffers![0].price!
                            .grandTotal ??
                        ''),
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
  const FlightDetail(
      {Key? key, required this.itinerary, required this.fareDetailsBySegment})
      : super(key: key);
  final Itinerary itinerary;
  final FareDetailsBySegment fareDetailsBySegment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
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
                _getDateTime(itinerary.segments![0].departure!.at ?? ''),
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
                _getDateTime(itinerary.segments![0].arrival!.at ?? ''),
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
                'Código',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                itinerary.segments![0].departure!.iataCode ?? '',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Código',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                itinerary.segments![0].arrival!.iataCode ?? '',
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
                'Código Vuelo',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                itinerary.segments![0].aircraft!.code ?? '',
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
                fareDetailsBySegment.cabin ?? '',
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

class ListPassengers extends StatefulWidget {
  ListPassengers(
      {Key? key,
      this.formKey,
      required this.searchTicket,
      required this.acceptOffer})
      : super(key: key);
  final formKey;
  final SearchTicket searchTicket;
  final AcceptOffer acceptOffer;

  @override
  _ListPassengersState createState() => _ListPassengersState();
}

class _ListPassengersState extends State<ListPassengers> {
  List<String> genders = ['Femenino', 'Masculino'];
  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 10),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createPassenger(0),
            (widget.searchTicket.travelersNumbers! >= 2)
                ? _createPassenger(1)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 3)
                ? _createPassenger(2)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 4)
                ? _createPassenger(3)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 5)
                ? _createPassenger(4)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 6)
                ? _createPassenger(5)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 7)
                ? _createPassenger(6)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 8)
                ? _createPassenger(7)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 9)
                ? _createPassenger(8)
                : Container(),
            (widget.searchTicket.travelersNumbers! >= 10)
                ? _createPassenger(9)
                : Container(),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getOptions() {
    List<DropdownMenuItem<String>> list = [];
    genders.forEach((option) {
      list.add(DropdownMenuItem(
        child: Text(option),
        value: (option == 'Femenino') ? 'FEMALE' : 'MALE',
      ));
    });
    return list;
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime now = new DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(now.year - 11),
      firstDate: new DateTime(now.year - 80),
      lastDate: new DateTime(now.year - 10),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      controller.text = picked.toString().substring(0, 10);
    }
  }

  Widget _createPassenger(int index) {
    return Column(
      children: <Widget>[
        Text(
          'Pasajero ' + (index + 1).toString(),
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: 'Nombre'),
          onSaved: (value) => widget
              .acceptOffer.data!.travelers![index].name!.firstName = value!,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: 'Apellido'),
          onSaved: (value) => widget
              .acceptOffer.data!.travelers![index].name!.lastName = value!,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
          controller: controllers[index],
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context, controllers[index]);
          },
          onSaved: (value) =>
              widget.acceptOffer.data!.travelers![index].dateOfBirth = value!,
        ),
        SizedBox(
          height: 6,
        ),
        DropdownButton(
          isExpanded: true,
          value: widget.acceptOffer.data!.travelers![index].gender,
          items: _getOptions(),
          onChanged: (opt) {
            setState(() {
              widget.acceptOffer.data!.travelers![index].gender =
                  opt.toString();
              print(opt);
            });
          },
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: 'Correo Electrónico'),
          onSaved: (value) => widget.acceptOffer.data!.travelers![index]
              .contact!.emailAddress = value!,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Teléfono Móvil'),
          onSaved: (value) =>
              widget.acceptOffer.data!.travelers![index].contact!.phones = [
            new Phone(deviceType: 'MOBILE', number: value.toString())
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
