import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class SignInPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          FormSignIn(scaffoldKey),
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
            image: AssetImage('assets/user.png'),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

class FormSignIn extends StatefulWidget {
  FormSignIn(this.scaffoldKey);
  final scaffoldKey;

  @override
  _FormSignInState createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  User user = new User();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    _createEmail(),
                    SizedBox(height: 20),
                    _createPassword(),
                    SizedBox(
                      height: 36,
                    ),
                    _createSignInButton(),
                    SizedBox(
                      height: 10,
                    ),
                    _createSignUpText(context)
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      children: <Widget>[
        Text(
          'Bienvenido,',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Inicia Sesión!',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _createEmail() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo Electrónico',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value ?? '') ? null : 'El correo es inválido.';
      },
      onSaved: (value) => user.correoElectronico = value!,
    );
  }

  Widget _createPassword() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => user.contrasena = value!,
    );
  }

  Widget _createSignInButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'INICIAR SESIÓN',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () {
                print('ON PRESSED LOGIN');
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                _login(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  _login(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(user.correoElectronico);
    print(user.contrasena);
    final resultLogin = await userProvider.login(user);
    if (resultLogin) {
      Navigator.pushReplacementNamed(context, 'main');
    } else {
      _showMessage('Correo o contraseña incorrectos.');
    }
  }

  Widget _createSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "No tienes una cuenta?",
          style: TextStyle(fontSize: 16),
        ),
        FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'signup'),
          child: Text(
            'Regístrate',
            style:
                TextStyle(fontSize: 16, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
