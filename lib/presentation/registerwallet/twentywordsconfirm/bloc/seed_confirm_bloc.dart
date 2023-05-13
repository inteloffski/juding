import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/registerwallet/twentywordsconfirm/bloc/seed_confirm_event.dart';
import 'package:juding/presentation/registerwallet/twentywordsconfirm/bloc/seed_confirm_state.dart';

class SeedConfirmBloc extends Bloc<SeedConfirmEvent, StateSeed> {

  SeedConfirmBloc() : super(InitSeedState()) {

    on<CheckingSeedEvent>((event, emit)  {
      if (listEquals(event.seedEntered, event.seedPass)) {
        emit(ValidSeedState());
      } else {
        emit(InvalidSeedState());
      }
    });
  }
}
