import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/providers/ClientProvider.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          FormSignUp(
            scaffoldKey: scaffoldKey,
          ),
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

class FormSignUp extends StatefulWidget {
  const FormSignUp({Key? key, @required this.scaffoldKey}) : super(key: key);
  final scaffoldKey;
  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  Client client = new Client();
  User user = new User();
  ClientProvider clientProvider = new ClientProvider();

  String _dateOfBirth = '';
  bool _gender = true;
  String _confirmPassword = '';

  TextEditingController _dateController = new TextEditingController();

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
                color: Colors.white70, borderRadius: BorderRadius.circular(18)),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _createCI(),
                  SizedBox(height: 15),
                  _createName(),
                  SizedBox(height: 15),
                  _createLastName(),
                  SizedBox(height: 15),
                  _createDateOfBirth(context),
                  SizedBox(height: 15),
                  _createGender(),
                  SizedBox(height: 15),
                  _createTelephone(),
                  SizedBox(height: 15),
                  _createDirection(),
                  SizedBox(height: 15),
                  _createPassport(),
                  SizedBox(height: 15),
                  _createNit(),
                  SizedBox(height: 15),
                  _createNitName(),
                  SizedBox(height: 15),
                  _createEmail(),
                  SizedBox(height: 15),
                  _createPassword(),
                  SizedBox(height: 15),
                  _createConfirmPassword(),
                  SizedBox(
                    height: 20,
                  ),
                  _createSignUpButton(context),
                  SizedBox(
                    height: 10,
                  ),
                  _createSignInText(context)
                ],
              ),
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
          'Crea',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'tu cuenta aquí',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _createCI() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'CI',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.ci = int.parse(value!),
    );
  }

  Widget _createName() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombres',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.nombres = value!,
    );
  }

  Widget _createLastName() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.apellidos = value!,
    );
  }

  Widget _createDateOfBirth(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      enableInteractiveSelection: false,
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'Fecha de Nacimiento',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(now.year - 11),
      firstDate: new DateTime(now.year - 80),
      lastDate: new DateTime(now.year - 10),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      _dateOfBirth = picked.toString().substring(0, 10);
      _dateController.text = _dateOfBirth;
      client.fechaNacimiento = _dateOfBirth;
    }
  }

  Widget _createGender() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'Género',
            style: TextStyle(fontSize: 16),
          ),
          Checkbox(
            value: !_gender,
            onChanged: (value) {
              setState(() {
                _gender = !value!;
                client.sexo = "M";
              });
            },
            activeColor: Color.fromRGBO(6, 6, 6, 1),
          ),
          Text(
            'M',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 50),
          Checkbox(
            value: _gender,
            onChanged: (value) {
              setState(() {
                _gender = value!;
                client.sexo = "F";
              });
            },
            activeColor: Color.fromRGBO(6, 6, 6, 1),
          ),
          Text(
            'F',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget _createTelephone() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Teléfono',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.telefono = int.parse(value!),
    );
  }

  Widget _createDirection() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Dirección',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.direccion = value!,
    );
  }

  Widget _createPassport() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Pasaporte',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.pasaporte = value!,
    );
  }

  Widget _createNit() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'NIT',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.nit = int.parse(value!),
    );
  }

  Widget _createNitName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombre NIT',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      onSaved: (value) => client.nombreNit = value!,
    );
  }

  Widget _createEmail() {
    return TextFormField(
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
      onSaved: (value) => client.correoElectronico = value!,
    );
  }

  Widget _createPassword() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe tener más de 6 caracteres por favor';
      },
      onSaved: (value) => client.contrasena = value!,
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
                'REGISTRARSE',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                formKey.currentState!.save();
                _register(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _createSignInText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ya tienes una cuenta?",
          style: TextStyle(fontSize: 15),
        ),
        FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'signin'),
          child: Text(
            'Inicia sesión',
            style:
                TextStyle(fontSize: 15, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  _register(BuildContext context) async {
    if (_confirmPassword == client.contrasena) {
      final resultRegister = await clientProvider.register(client);
      if (resultRegister) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        user.correoElectronico = client.correoElectronico;
        user.contrasena = client.contrasena;
        final resultLogin = await userProvider.login(user);
        if (resultLogin) {
          Navigator.pushReplacementNamed(context, 'main');
        } else {
          Navigator.pushReplacementNamed(context, 'signin');
        }
      } else {
        _showMessage(
            'No se pudo registrar el usuario. Inténtelo nuevamente por favor.');
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
