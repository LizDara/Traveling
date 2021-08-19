import 'package:flutter/material.dart';
import 'package:traveling/src/models/region_model.dart';
import 'package:traveling/src/widgets/RegionSearchDelegate.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(), FormReservation()],
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
              Color.fromRGBO(89, 72, 119, 1),
              Color.fromRGBO(149, 86, 135, 1)
            ]),
      ),
    );
  }

  Container _createImage() {
    return Container(
      child: Image(
        image: AssetImage('assets/ticket.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class FormReservation extends StatefulWidget {
  const FormReservation({
    Key? key,
  }) : super(key: key);

  @override
  _FormReservationState createState() => _FormReservationState();
}

class _FormReservationState extends State<FormReservation> {
  dynamic departure = new Region();
  dynamic destination = new Region();
  TextEditingController departureController = new TextEditingController();
  TextEditingController destinationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            _createTitle(),
            SizedBox(
              height: 10,
            ),
            _createDeparture(context),
            SizedBox(
              height: 6,
            ),
            _createDestination(context),
            SizedBox(
              height: 20,
            ),
            _createGoButton(context)
          ],
        )),
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Encuentra',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(
          'tu vuelo aquí',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _createDeparture(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        color: Colors.white,
        child: TextFormField(
            enableInteractiveSelection: false,
            controller: departureController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                labelText: 'Desde',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                icon: Icon(
                  Icons.flight_takeoff,
                ),
                border: InputBorder.none),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _getDepartureRegion(context);
            }),
      ),
    );
  }

  _getDepartureRegion(BuildContext context) async {
    departure =
        await showSearch(context: context, delegate: RegionSearchDelegate());
    departureController.text = departure.name;
  }

  Widget _createDestination(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        color: Colors.white,
        child: TextFormField(
            enableInteractiveSelection: false,
            controller: destinationController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                labelText: 'Hasta',
                labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                icon: Icon(
                  Icons.flight_land,
                ),
                border: InputBorder.none),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _getDestinationRegion(context);
            }),
      ),
    );
  }

  _getDestinationRegion(BuildContext context) async {
    destination =
        await showSearch(context: context, delegate: RegionSearchDelegate());
    destinationController.text = destination.name;
  }

  Widget _createGoButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'VAMOS',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () {
                List<Region> regions = [departure, destination];
                Navigator.pushNamed(context, 'details', arguments: regions);
              },
            ),
          ),
        ),
      ],
    );
  }
}
