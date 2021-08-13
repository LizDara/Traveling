import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class ProfilePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          FormButton(
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

class FormButton extends StatefulWidget {
  const FormButton({Key? key, @required this.scaffoldKey}) : super(key: key);
  final scaffoldKey;
  @override
  _FormButtonState createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  User user = new User();

  UserProvider userProvider = new UserProvider();

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
              'Alicia',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Garcia',
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
          'Editar perfil',
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
          'Cambiar contraseña',
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
          'Cerrar sesión',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Expanded(child: Container()),
        IconButton(
            icon:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            onPressed: () => _logout(context))
      ],
    );
  }

  _logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final tokens = await userProvider.readToken();
    user.accessToken = tokens[0];
    user.refreshToken = tokens[1];
    final resultLogout = await userProvider.logout(user);
    if (resultLogout) {
      Navigator.pushReplacementNamed(context, 'welcome');
    } else {
      _showMessage('No se pudo cerrar sesión. Inténtelo nuevamente por favor.');
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
