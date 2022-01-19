import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:registration_screen/injection.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: const SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) {
            either.fold(
              (failure) {
                FlushbarHelper.createError(
                  message: failure.map(
                    servetError: (_) => "Server error",
                    emailAlreadyInUse: (_) => "Email already in use",
                    invalidEmailAndPasswordCombination: (_) =>
                        "Invalid email and password combination",
                  ),
                ).show(context);
              },
              (_) {},
            );
          },
        );
      },
      builder: (context, state) {
        return Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: const Icon(Icons.email), labelText: "Email"),
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => "Invalid Email",
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                obscureText: true,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .password
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => "Short password",
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          BlocProvider.of<SignInFormBloc>(context).add(
                        const SignInFormEvent
                            .registerWithEmailAndPasswordPressed(),
                      ),
                      child: const Text("REGISTER"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => BlocProvider.of<SignInFormBloc>(context)
                          .add(const SignInFormEvent
                              .signInWithEmailAndPasswordPressed()),
                      child: const Text("SIGN IN"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
