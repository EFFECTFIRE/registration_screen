import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/sign_in_form_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/welcome_screen.dart';

import 'application/user_bloc.dart';
import 'application/user_states.dart';

void main() {
  MaterialApp(
    title: "Registration",
    supportedLocales: <Locale>[Locale('en', 'EN')],
    home: BlocProvider(
        create: (context) => UserBloc(UserLogOutState()),
        child: RegistrationScreen()),
  );
}

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  GlobalKey _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("RegistrationScreen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: _passwordTextController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextButton(
              onPressed: () {
                _userBloc.add((UserLogInEvent(
                    _emailTextController.text, _passwordTextController.text)));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
