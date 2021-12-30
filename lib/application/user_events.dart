abstract class UserEvent {
  String? get email => null;
  String? get password => null;
}

class UserLogInEvent extends UserEvent {
  @override
  final String _email;
  @override
  String get email => _email;

  final String _password;
  @override
  String get password => _password;

  UserLogInEvent(this._email, this._password);
}

class UserLogOutEvent extends UserEvent {}

class UserLogUpEvent extends UserEvent {
  final String _email;
  @override
  String get email => _email;
  final String _password;
  @override
  String get password => _password;

  UserLogUpEvent(this._email, this._password);
}
