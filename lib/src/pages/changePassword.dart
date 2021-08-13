import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

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
    Key? key,
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
            image: AssetImage('assets/woman.png'),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({Key? key, this.scaffoldKey}) : super(key: key);
  final scaffoldKey;

  @override
  _FormChangePasswordState createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  User user = new User();

  String _actualPassword = '';
  String _confirmPassword = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return FutureBuilder(
      future: userProvider.readToken(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) Container();
        user.accessToken = snapshot.data![0];
        user.refreshToken = snapshot.data![1];
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
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(18)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      _createPassword(),
                      SizedBox(height: 15),
                      _createNewPassword(),
                      SizedBox(height: 15),
                      _createConfirmPassword(),
                      SizedBox(
                        height: 20,
                      ),
                      _createSignUpButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _createPassword() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => _actualPassword = value!,
    );
  }

  Widget _createNewPassword() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Nueva Contraseña',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe tener más de 6 caracteres por favor';
      },
      onSaved: (value) => user.contrasena = value!,
    );
  }

  Widget _createConfirmPassword() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirmar Contraseña',
        hintStyle: TextStyle(
          color: Color.fromRGBO(6, 6, 6, 1),
        ),
      ),
      onSaved: (value) => _confirmPassword = value!,
    );
  }

  Widget _createSignUpButton(BuildContext context) {
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
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                _save(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  _save(BuildContext context) async {
    if (_confirmPassword == user.contrasena) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final resultUpdate = await userProvider.updatePassword(user);
      if (resultUpdate) {
        await userProvider.clearTokens();
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
