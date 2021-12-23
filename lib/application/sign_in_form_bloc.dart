import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_screen/auth/auth_failure.dart';
import 'package:registration_screen/auth/i_auth_facade.dart';
import 'package:registration_screen/auth/value_objects.dart';

part 'sign_in_form_state.dart';
part 'sign_in_form_event.dart';

part "sign_in_form_bloc.freezed.dart";

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade);

  SignInFormState get initialState => SignInFormState.initial();

  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
        emailChanged: (e) async* {
          yield state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            authFailureOrSuccessOption: none(),
          );
        },
        passwordChanged: (e) async* {
          yield state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none(),
          );
        },
        registerWithEmailAndPasswordPressed: (e) async* {},
        signInWithEmailAndPasswordPressed: (e) async* {});
  }
}
