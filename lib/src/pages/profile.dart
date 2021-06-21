import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[Background(), FormButton()],
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
}

class FormButton extends StatelessWidget {
  const FormButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60, bottom: 20, left: 25, right: 14),
      child: Column(
        children: <Widget>[
          _createInformation(),
          SizedBox(
            height: 20,
          ),
          _createEditProfileButton(context),
          _createChangePasswordButton(context),
          _createLine(),
          _createLogoutButton(context),
          //Expanded(child: Container()),
          //_createImage(context)
        ],
      ),
    );
  }

  Widget _createInformation() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              child: Image(
                image: AssetImage('assets/woman.png'),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Marie',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Anderson',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createEditProfileButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.edit, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Edit profile',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, 'account'))
      ],
    );
  }

  Widget _createChangePasswordButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.lock_outline, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Change password',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, 'password'))
      ],
    );
  }

  Widget _createLine() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 4, right: 18),
          height: 1.5,
          color: Colors.black87,
        )),
      ],
    );
  }

  Widget _createLogoutButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.exit_to_app, size: 30, color: Colors.black87),
        SizedBox(
          width: 14,
        ),
        Text(
          'Log out',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => Navigator.pushReplacementNamed(context, 'welcome'))
      ],
    );
  }

  Widget _createImage(BuildContext context) {
    return Image(
      image: AssetImage('assets/traveling.png'),
      height: MediaQuery.of(context).size.height / 4,
      color: Colors.black54,
    );
  }
}
