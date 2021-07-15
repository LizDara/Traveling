import 'package:flutter/material.dart';
import 'package:traveling/src/blocs/provider.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          FormChangePassword(
            scaffoldKey: scaffoldKey,
          )
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
      children: <Widget>[_createBackground(), _createIcon(context)],
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

  Widget _createIcon(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width * 5 / 9,
          height: size.height * 2 / 7,
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(140)),
              color: Colors.white60),
          child: Image(
            image: AssetImage('assets/user.png'),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({Key key, this.scaffoldKey}) : super(key: key);
  final scaffoldKey;

  @override
  _FormChangePasswordState createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  User user = new User();
  UserProvider userProvider = new UserProvider();

  String _actualPassword = '';
  String _confirmPassword = '';

  final UserPreferences preferences = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    bloc.emailSink('example@gmail.com');

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 7,
          ),
          _createTitle(),
          SizedBox(
            height: 14,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: <Widget>[
                _createPassword(bloc),
                SizedBox(height: 15),
                _createNewPassword(bloc),
                SizedBox(height: 15),
                _createConfirmPassword(bloc),
                SizedBox(
                  height: 20,
                ),
                _createSignUpButton(context, bloc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      children: <Widget>[
        Text(
          'Cambia',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'tu contraseña',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onChanged: (value) => _actualPassword = value,
    );
  }

  Widget _createNewPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Nueva Contraseña',
              hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
              errorText: snapshot.error),
          onChanged: bloc.passwordSink,
          //onSaved: (value) => client.contrasena = value,
        );
      },
    );
  }

  Widget _createConfirmPassword(LoginBloc bloc) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirmar Contraseña',
        hintStyle: TextStyle(
          color: Color.fromRGBO(6, 6, 6, 1),
        ),
      ),
      onChanged: (value) => _confirmPassword = value,
    );
  }

  Widget _createSignUpButton(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'GUARDAR',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Color.fromRGBO(6, 6, 6, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    if (!snapshot.hasData) return;
                    _save(context, bloc);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _save(BuildContext context, LoginBloc bloc) async {
    if (_confirmPassword == bloc.password) {
      user.contrasena = bloc.password;
      user.accessToken = preferences.accessToken;
      user.refreshToken = preferences.refreshToken;
      final resultUpdate = await userProvider.updatePassword(user);
      if (resultUpdate) {
        preferences.clearPreferences();
        Navigator.pushReplacementNamed(context, 'signin');
      } else {
        _showMessage(
            'No se pudo modificar la contraseña. Inténtelo nuevamente por favor.');
      }
    } else {
      _showMessage('Las contraseñas no coinciden. Favor de verificar.');
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
