import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/restorewallet/bloc/restore_waller_state.dart';
import 'package:juding/presentation/restorewallet/bloc/restore_wallet_event.dart';

import '../../../repository/register/register_repository.dart';

class RestoreWalletBloc extends Bloc<RestoreWalletEvent, RestoreWalletState> {
  final RegisterRepository repository;

  RestoreWalletBloc({required this.repository})
      : super(InitRestoreWalletState()) {
    on<ValidateRestoreEvent>((event, emit) => {
          if (repository.validateMnemonic(event.mnemonic))
            {emit(ValidateRestoreState())}
          else
            {emit(InvalidRestoreState())}
        });
  }
}
