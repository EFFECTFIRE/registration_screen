import 'package:registration_screen/auth/value_objects.dart';
import 'package:registration_screen/domain/data_model.dart';

abstract class UserState {}

class UserLogInState extends UserState {
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;
  UserLogInState(this._email, this._password);
}

class UserLogOutState extends UserState {}

class UserLogUpState extends UserState {}
