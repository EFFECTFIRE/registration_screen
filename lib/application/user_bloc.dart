import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_screen/application/user_events.dart';
import 'package:registration_screen/application/user_states.dart';
import 'package:registration_screen/domain/data_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState initialState) : super(initialState);
  final MainRepo repo = MainRepo();

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLogInEvent) {
      if (await repo.logInWithEmailAndPassword(event.email, event.password)) {
        yield UserLogInState(event.email, event.password);
      } else if (event is UserLogUpEvent) {
        if (await repo.logUpWithEmailAndPassword(event.email, event.password)) {
          yield UserLogUpState();
        }
      } else if (event is UserLogOutEvent) {
        if (await repo.logOut()) {
          yield UserLogOutState();
        }
      }
    }
  }
}
