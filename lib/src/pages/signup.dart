import 'package:flutter/material.dart';
import 'package:traveling/src/blocs/provider.dart';
import 'package:traveling/src/models/client_model.dart';
import 'package:traveling/src/providers/ClientProvider.dart';

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
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Background(),
          FormSignUp(),
        ],
      )),
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
        Positioned(
            left: -85, top: -75, child: _createCircle(220, 210, 155, 134, 0.9)),
        Positioned(
            left: 40, top: -120, child: _createCircle(210, 135, 134, 210, 0.9))
      ],
    );
  }

  Widget _createCircle(double size, int r, int g, int b, double opacity) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180),
        color: Color.fromRGBO(r, g, b, opacity),
      ),
    );
  }
}

class FormSignUp extends StatefulWidget {
  const FormSignUp({
    Key key,
  }) : super(key: key);

  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  Client client = new Client();
  ClientProvider clientProvider = new ClientProvider();

  String _dateOfBirth = '';
  bool _gender = true;

  TextEditingController _dateController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              _createTitle(),
              SizedBox(
                height: 25,
              ),
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
              _createEmail(bloc),
              SizedBox(height: 15),
              _createPassword(bloc),
              SizedBox(
                height: 20,
              ),
              _createSignUpButton(context, bloc),
              SizedBox(
                height: 10,
              ),
              _createSignInText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Create',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'your account',
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'CI',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.ci = int.parse(value),
    );
  }

  Widget _createName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Name',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.nombres = value,
    );
  }

  Widget _createLastName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.apellidos = value,
    );
  }

  Widget _createDateOfBirth(BuildContext context) {
    return Container(
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: _dateController,
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
          border: OutlineInputBorder(),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
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
      client.fechaNacimiento = picked.toString().substring(0, 10);
    }
  }

  Widget _createGender() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'Gender',
            style: TextStyle(fontSize: 16),
          ),
          Checkbox(
            value: !_gender,
            onChanged: (female) {
              setState(() {
                _gender = !female;
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
            onChanged: (female) {
              setState(() {
                _gender = female;
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
        labelText: 'Telephone',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.telefono = int.parse(value),
    );
  }

  Widget _createDirection() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Direction',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.direccion = value,
    );
  }

  Widget _createPassport() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Passport',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.pasaporte = value,
    );
  }

  Widget _createNit() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'NIT',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.nit = int.parse(value),
    );
  }

  Widget _createNitName() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'NIT Name',
        hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
        border: OutlineInputBorder(),
      ),
      onSaved: (value) => client.nombreNit = value,
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email',
                hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
                border: OutlineInputBorder(),
                errorText: snapshot.error),
            onChanged: bloc.emailSink,
            onSaved: (value) => client.correoElectronico = value,
          );
        });
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password',
              hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
              border: OutlineInputBorder(),
              errorText: snapshot.error),
          onChanged: bloc.passwordSink,
          onSaved: (value) => client.contrasena = value,
        );
      },
    );
  }

  Widget _createSignUpButton(BuildContext context, LoginBloc bloc) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'SIGN UP',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromRGBO(6, 6, 6, 1),
              textColor: Colors.white,
              onPressed: () {
                if (!formKey.currentState.validate()) return;
                formKey.currentState.save();
                _register(context, bloc);
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
          "Already have an account?",
          style: TextStyle(fontSize: 16),
        ),
        FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'signin'),
          child: Text(
            'Sign in',
            style:
                TextStyle(fontSize: 16, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  _register(BuildContext context, LoginBloc bloc) async {
    final resultRegister = await clientProvider.register(client);
    if (resultRegister) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      print("ERROR!!");
    }
  }
}
