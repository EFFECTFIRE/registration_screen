import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/sign_in_form/sign_in_form_bloc.dart';

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
        ),
        body: BlocBuilder<SignInFormBloc, SignInFormState>(
            bloc: BlocProvider.of<SignInFormBloc>(context, listen: false),
            builder: (context, state) {
              return Center(
                child: Column(
                  children: [
                    Text("Email: ${state.emailAddress.toString}"),
                    Text("Password: ${state.password.toString}")
                  ],
                ),
              );
            }));
  }
}
