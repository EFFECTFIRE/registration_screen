import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as a;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:registration_screen/domain/auth/auth_failure.dart';
import 'package:registration_screen/domain/auth/i_auth_facade.dart';
import 'package:registration_screen/domain/auth/value_objects.dart';
import 'package:registration_screen/infrastructure/auth/firebase_user_mapper.dart';
import 'package:registration_screen/domain/auth/user.dart' as b;

@prod
@lazySingleton
@Injectable(as: IAuthFacade, env: [Environment.dev, Environment.prod])
class FirebaseAuthFacade implements IAuthFacade {
  final a.FirebaseAuth _firebaseAuth;
  final FirebaseUserMapper _firebaseUserMapper;

  FirebaseAuthFacade(this._firebaseAuth, this._firebaseUserMapper);

  @override
  Future<Option<b.User>> getSignedInUser() async {
    return optionOf(_firebaseUserMapper.toDomain(_firebaseAuth.currentUser!));
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailAddressStr, password: passwordStr)
          .then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.servetError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(
              email: emailAddressStr, password: passwordStr)
          .then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == "ERROR_WRONG_PASSWORD" ||
          e.code == "ERROR_USER_NOT_FOUND") {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.servetError());
      }
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
