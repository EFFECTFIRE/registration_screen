import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';
import 'package:registration_screen/domain/data_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final MainRepo repo = MainRepo();

  UserBloc(UserState initialState) : super(UserLogOutState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    try {
      if (event is UserLogInEvent) {
        if (await repo.logInWithEmailAndPassword(event.email, event.password)) {
          yield UserLogInState(event.email, event.password);
        } else if (event is UserLogUpEvent) {
          if (await repo.logUpWithEmailAndPassword(
              event.email, event.password)) {
            yield UserLogUpState(repo.data.email, repo.data.uid);
          }
        } else if (event is UserLogOutEvent) {
          if (await repo.logOut()) {
            yield UserLogOutState();
          }
        }
      }
    } on Exception catch (e) {
      yield UserLogOutState();
    }
  }
}
