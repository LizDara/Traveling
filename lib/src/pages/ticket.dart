import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[Background(), Detail()],
        ),
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
        Container(
          margin: EdgeInsets.fromLTRB(25, 20, 25, 25),
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
          'DHK',
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
          'SIN',
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
          'Dhaka, Bangladesh',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          'Changi, Singapore',
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
              height: MediaQuery.of(context).size.height * 2 / 9,
            ),
            TicketDetails(),
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
                'DONE',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () => Navigator.pushNamed(context, 'home')),
        )),
      ],
    );
  }
}

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    Key key,
  }) : super(key: key);

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
          FlightDetail(),
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
          SizedBox(
            height: 80,
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
                'Ticket Price',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                r'$ 695',
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
  const FlightDetail({
    Key key,
  }) : super(key: key);

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
                'Depart',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Sun, March 26',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Arrive',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Thu, March 30',
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
                'Gate',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'B7',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Seat',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '21A',
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
                'Flight Number',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'KC89',
                style: TextStyle(
                    color: Color.fromRGBO(6, 6, 6, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                'Class',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Business',
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
}
