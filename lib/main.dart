import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/welcome_screen.dart';

import 'application/user_bloc.dart';
import 'application/user_states.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, AsyncSnapshot<FirebaseApp> snapshot) =>
          BlocProvider<UserBloc>(
              create: (context) => UserBloc(UserLogOutState()),
              child: MaterialApp(
                home: RegistrationScreen(),
              )),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                BlocProvider.of<UserBloc>(context, listen: false).add(
                    UserLogUpEvent(_emailTextController.text,
                        _passwordTextController.text));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<UserBloc>(context),
                              child: WelcomeScreen(),
                            )));
              },
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
