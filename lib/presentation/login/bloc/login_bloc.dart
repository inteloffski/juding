import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/login/bloc/login_event.dart';
import 'package:juding/presentation/login/bloc/login_state.dart';

import '../../../repository/session/session_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionRepository repository;

  LoginBloc({required this.repository}) : super(InitLoginState()) {
    on<ValidateLoginEvent>((event, emit) async {
      String address = await repository.authSession(event.password);
      await repository.fetchPrivateKey(event.password);
      if (address.isNotEmpty) {
        emit(ValidateLoginState());
      } else {
        emit(InvalidateLoginState());
      }
    });
  }
}
