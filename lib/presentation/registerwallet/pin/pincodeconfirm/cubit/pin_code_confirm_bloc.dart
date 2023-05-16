import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_event.dart';
import 'package:juding/presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_state.dart';
import 'package:juding/repository/register/register_repository.dart';

import '../../../../../repository/session/session_repository.dart';

class PinCodeConfirmBloc extends Bloc<PinCodeEvent, PinCodeConfirmState> {
  final RegisterRepository registerRepository;
  final SessionRepository sessionRepository;

  PinCodeConfirmBloc({
    required this.registerRepository,
    required this.sessionRepository,
  }) : super(InitPinCodeState()) {
    on<PinCodeCheckingEvent>((event, emit) async {
      if (event.pinCodeConfirmed == event.pinCodeEntered) {
        registerRepository.registerNewWallet(event.pinCodeEntered, event.seed);
        await sessionRepository.authSession(event.pinCodeEntered);
        await sessionRepository.fetchPrivateKey(event.pinCodeEntered);
        emit(ValidPinCodeState());
      } else {
        emit(InvalidPinCodeState());
      }
    });
  }
}
