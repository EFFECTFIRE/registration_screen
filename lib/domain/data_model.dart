import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:registration_screen/application/user_states.dart';

class MainData {
  final FirebaseAuth firebaseInst = FirebaseAuth.instance;
  late String _email;
  String get email => _email;
  late String _uid;
  String get uid => _uid;

  void setState(UserState newState, {String uid = '', String email = ''}) {
    _uid = uid;
    _email = email;
  }
}

class MainRepo {
  MainData data = MainData();
  late User _currentUser;
  FirebaseAuth get firebaseInst => data.firebaseInst;

  Future<bool> logInWithEmailAndPassword(String email, String password) async {
    User? dataUser;
    try {
      dataUser = (await firebaseInst.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return false;
        case "user-not-found":
          return false;
        case "user-disabled":
          return false;
        case "invalid-email":
          return false;
        default:
          return true;
      }
    }

    if (dataUser == null) {
      data.setState(UserLogOutState());
      return false;
    }
    _currentUser = dataUser;
    data.setState(UserLogInState(email, password),
        uid: _currentUser.uid, email: _currentUser.email!);
    return true;
  }

  Future<bool> logUpWithEmailAndPassword(String email, String password) async {
    await Firebase.initializeApp();
    try {
      await firebaseInst.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return false;
        case "weak-password":
          return false;
        case "invalid-email":
          return false;
        case "operation-not-allowed":
          return false;
        default:
          return false;
      }
    }
  }

  Future<bool> logOut() async {
    if (firebaseInst != null) {
      firebaseInst.signOut();
    }
    data.setState(UserLogOutState());
    return true;
  }
}
