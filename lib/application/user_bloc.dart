import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';
import 'package:registration_screen/domain/data_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final MainRepo repo = MainRepo();

  UserBloc(UserState initialState) : super(initialState) {
    on<UserLogInEvent>((event, emit) async {
      try {
        if (await repo.logInWithEmailAndPassword(event.email, event.password)) {
          emit(UserLogInState(event.email, event.password));
        }
      } on FirebaseAuthException catch (e) {
        emit(UserLogErrorState(e.code));
      }
    });
    on<UserLogUpEvent>((event, emit) async {
      try {
        await repo.logUpWithEmailAndPassword(event.email, event.password);
        emit(UserLogUpState(event.email, event.password));
      } on FirebaseAuthException catch (e) {
        emit(UserLogErrorState(e.code));
      }
    });
    on<UserLogOutEvent>((event, emit) async {
      try {
        await repo.logOut();
        emit(UserLogOutState());
      } on FirebaseAuthException catch (e) {
        emit(UserLogErrorState(e.code));
      }
    });
  }

  // @override
  // Stream<UserState> mapEventToState(UserEvent event) async* {
  //   try {
  //     if (event is UserLogInEvent) {
  //       if (await repo.logInWithEmailAndPassword(event.email, event.password)) {
  //         yield UserLogInState(event.email, event.password);
  //       } else if (event is UserLogUpEvent) {
  //         if (await repo.logUpWithEmailAndPassword(
  //             event.email, event.password)) {
  //           yield UserLogUpState(repo.data.email, repo.data.uid);
  //         }
  //       } else if (event is UserLogOutEvent) {
  //         if (await repo.logOut()) {
  //           yield UserLogOutState();
  //         }
  //       }
  //     }
  //   } on Exception catch (e) {
  //     yield UserLogOutState();
  //   }
  // }
}
