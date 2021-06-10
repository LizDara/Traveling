import 'package:flutter/material.dart';
import 'package:traveling/src/blocs/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Background(),
            FormSignIn(),
          ],
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

class FormSignIn extends StatelessWidget {
  const FormSignIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              _createTitle(),
              SizedBox(
                height: 20,
              ),
              _createEmail(bloc),
              SizedBox(height: 20),
              _createPassword(bloc),
              SizedBox(
                height: 30,
              ),
              _createSignInButton(bloc),
              SizedBox(
                height: 10,
              ),
              _createSignUpText(context)
            ],
          )),
    );
  }

  Widget _createTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Welcome back,',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Sign in!',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email',
                hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
                border: OutlineInputBorder()),
            onChanged: bloc.emailSink,
          );
        });
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                hintStyle: TextStyle(color: Color.fromRGBO(6, 6, 6, 1)),
                border: OutlineInputBorder()),
            onChanged: bloc.passwordSink,
          );
        });
  }

  Widget _createSignInButton(LoginBloc bloc) {
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
                      'SIGN IN',
                      style: TextStyle(fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Color.fromRGBO(6, 6, 6, 1),
                    textColor: Colors.white,
                    onPressed:
                        snapshot.hasData ? () => _login(bloc, context) : null),
              ),
            ),
          ],
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _createSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16),
        ),
        FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'signup'),
          child: Text(
            'Sign up',
            style:
                TextStyle(fontSize: 16, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
