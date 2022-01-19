import 'package:firebase_auth/firebase_auth.dart' as a;
import 'package:injectable/injectable.dart';
import 'package:registration_screen/domain/auth/value_objects.dart';
import 'package:registration_screen/domain/core/value_objects.dart';
import 'package:registration_screen/domain/auth/user.dart' as b;

@lazySingleton
class FirebaseUserMapper {
  b.User? toDomain(a.User _) {
    return _ == null
        ? null
        : b.User(
            id: UniqueId.fromUniqueString(_.uid),
            name: StringSingleLine(_.displayName ?? _.email!.split("@").first),
            emailAddress: EmailAddress(_.email!),
          );
  }
}
