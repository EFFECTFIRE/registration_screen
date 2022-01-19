abstract class UserState {
  String? get email => null;
  String? get password => null;
}

class UserLogInState extends UserState {
  final String _email;
  @override
  String get email => _email;
  final String _password;
  @override
  String get password => _password;
  UserLogInState(this._email, this._password);
}

class UserLogOutState extends UserState {}

class UserLogUpState extends UserState {
  final String _email;
  @override
  String get email => _email;
  final String _password;
  @override
  String get password => _password;
  UserLogUpState(this._email, this._password);
}

class UserLogErrorState extends UserState {
  late String errorCode;
  UserLogErrorState(this.errorCode);
}
