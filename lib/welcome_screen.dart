import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/sign_in_form_bloc.dart';
import 'package:registration_screen/application/user_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter login demo"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => _userBloc.add(UserLogOutEvent()),
                child: Text("LogOut"))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text("Email: ${_userBloc.repo.data.email}"),
              Text("Uid: ${_userBloc.repo.data.uid}")
            ],
          ),
        ));
  }
}
