import 'package:registration_screen/auth/value_objects.dart';

abstract class UserEvent {
  String? get email => null;
  String? get password => null;
}

class UserLogInEvent extends UserEvent {
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;

  UserLogInEvent(this._email, this._password);
}

class UserLogOutEvent extends UserEvent {}

class UserLogUpEvent extends UserEvent {
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;

  UserLogUpEvent(this._email, this._password);
}
