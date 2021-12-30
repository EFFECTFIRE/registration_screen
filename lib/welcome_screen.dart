import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Flutter login demo"),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () =>
                      BlocProvider.of<UserBloc>(context, listen: false)
                          .add(UserLogOutEvent()),
                  child: Text("LogOut")),
            ]),
        body: BlocBuilder<UserBloc, UserState>(
            bloc: BlocProvider.of<UserBloc>(context, listen: false),
            builder: (context, state) {
              if (state is UserLogInState || state is UserLogUpState) {
                return Center(
                  child: Column(
                    children: [
                      Text("Email: ${state.email}"),
                      Text("Password: ${state.password}")
                    ],
                  ),
                );
              } else if (state is UserLogOutState) {
                return Center(
                  child: Text("FUCK"),
                );
              } else {
                return Center(
                  child: Text("IDONTUNDERSTAND"),
                );
              }
            }));
  }
}
