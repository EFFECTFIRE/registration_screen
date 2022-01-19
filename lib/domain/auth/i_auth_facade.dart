import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:registration_screen/domain/auth/auth_failure.dart';
import 'package:registration_screen/domain/auth/user.dart';
import 'package:registration_screen/domain/auth/value_objects.dart';

@module
abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signOut();
}
