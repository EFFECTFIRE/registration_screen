import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter login demo"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => BlocProvider.of<UserBloc>(context)
                    .mapEventToState(UserLogOutEvent()),
                child: Text("LogOut"))
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => Center(
            child: Column(
              children: [
                Text("Email: ${state.email}"),
                Text("Password: ${state.password}")
              ],
            ),
          ),
        ));
  }
}
