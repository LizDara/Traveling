import 'package:flutter/material.dart';
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/models/user_model.dart';
import 'package:traveling/src/preferences/user_preferences.dart';
import 'package:traveling/src/providers/ClientProvider.dart';
import 'package:traveling/src/providers/UserProvider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          FormEdit(
            scaffoldKey: scaffoldKey,
          ),
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

class FormEdit extends StatefulWidget {
  const FormEdit({Key key, this.scaffoldKey}) : super(key: key);
  final scaffoldKey;

  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final UserPreferences preferences = new UserPreferences();

  Client client = new Client();
  User user = new User();
  ClientProvider clientProvider = new ClientProvider();
  UserProvider userProvider = new UserProvider();

  String _dateOfBirth = '';
  bool _gender = true;

  TextEditingController _dateController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    user.accessToken = preferences.accessToken;
    user.refreshToken = preferences.refreshToken;

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
          _createForm(),
        ],
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      children: <Widget>[
        Text(
          'Edita',
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

  Widget _createForm() {
    return FutureBuilder(
      future: clientProvider.getClient(user),
      builder: (BuildContext context, AsyncSnapshot<Client> snapshot) {
        if (snapshot.hasData) {
          client = snapshot.data;
          _gender = (client.sexo == 'M') ? false : true;
          _dateController.text = client.fechaNacimiento.substring(0, 10);
          client.fechaNacimiento = client.fechaNacimiento.substring(0, 10);

          return Container(
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
                  SizedBox(
                    height: 20,
                  ),
                  _createEditButton(context),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
            ),
          );
        }
      },
    );
  }

  Widget _createCI() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'CI',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.ci.toString(),
      onSaved: (value) => client.ci = int.parse(value),
    );
  }

  Widget _createName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombres',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.nombres,
      onSaved: (value) => client.nombres = value,
    );
  }

  Widget _createLastName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Apellidos',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.apellidos,
      onSaved: (value) => client.apellidos = value,
    );
  }

  Widget _createDateOfBirth(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'Fecha de Nacimiento',
        hintStyle: TextStyle(
          color: Color.fromRGBO(6, 6, 6, 1),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(now.year - 11),
        firstDate: new DateTime(now.year - 80),
        lastDate: new DateTime(now.year - 10));
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
            onChanged: (isFemale) {
              setState(() {
                _gender = !isFemale;
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
            onChanged: (isFemale) {
              setState(() {
                _gender = !isFemale;
                client.sexo = "F";
                print('GÉNERO');
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
      initialValue: client.telefono.toString(),
      onSaved: (value) => client.telefono = int.parse(value),
    );
  }

  Widget _createDirection() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Dirección',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.direccion,
      onSaved: (value) => client.direccion = value,
    );
  }

  Widget _createPassport() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Pasaporte',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.pasaporte,
      onSaved: (value) => client.pasaporte = value,
    );
  }

  Widget _createNit() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'NIT',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.nit.toString(),
      onSaved: (value) => client.nit = int.parse(value),
    );
  }

  Widget _createNitName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nombre NIT',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
      ),
      initialValue: client.nombreNit,
      onSaved: (value) => client.nombreNit = value,
    );
  }

  Widget _createEditButton(BuildContext context) {
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
                if (!formKey.currentState.validate()) return;
                formKey.currentState.save();
                _update(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  _update(BuildContext context) async {
    client.accessToken = preferences.accessToken;
    client.refreshToken = preferences.refreshToken;
    final resultUpdate = await clientProvider.update(client);
    if (resultUpdate) {
      Navigator.pushReplacementNamed(context, 'main');
    } else {
      _showMessage(
          'No se pudo modificar los datos. Inténtelo nuevamente por favor.');
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
