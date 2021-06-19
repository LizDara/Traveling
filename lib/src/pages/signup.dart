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
      body: Stack(
        children: <Widget>[
          Background(),
          FormSignUp(),
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
                  _createEmail(bloc),
                  SizedBox(height: 15),
                  _createPassword(bloc),
                  SizedBox(height: 15),
                  _createConfirmPassword(bloc),
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
        ],
      ),
    );
  }

  Widget _createTitle() {
    return Column(
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
              errorText: snapshot.error),
          onChanged: bloc.passwordSink,
          onSaved: (value) => client.contrasena = value,
        );
      },
    );
  }

  Widget _createConfirmPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
              errorText: snapshot.error),
          //onChanged: bloc.passwordSink,
          //onSaved: (value) => client.contrasena = value,
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
          style: TextStyle(fontSize: 15),
        ),
        FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'signin'),
          child: Text(
            'Sign in',
            style:
                TextStyle(fontSize: 15, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  _register(BuildContext context, LoginBloc bloc) async {
    final resultRegister = await clientProvider.register(client);
    if (resultRegister) {
      Navigator.pushReplacementNamed(context, 'main');
    } else {
      print("ERROR!!");
    }
  }
}
